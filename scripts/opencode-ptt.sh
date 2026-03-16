#!/usr/bin/env bash
set -euo pipefail

STATE_DIR="${PTT_STATE_DIR:-/tmp/opencode-ptt}"
STATE_FILE="$STATE_DIR/state.env"
WHISPER_BIN="${WHISPER_BIN:-$HOME/whisper/build/bin/whisper-cli}"
WHISPER_MODEL="${WHISPER_MODEL:-$HOME/whisper/models/ggml-base.en.bin}"
PTT_ARECORD_DEVICE="${PTT_ARECORD_DEVICE:-}"

focused_window_pid() {
  local active_window=""
  local pid=""

  if command -v xprop >/dev/null 2>&1; then
    active_window="$(xprop -root _NET_ACTIVE_WINDOW 2>/dev/null | awk '{print $5}')"
    if [[ -n "$active_window" && "$active_window" != "0x0" ]]; then
      pid="$(xprop -id "$active_window" _NET_WM_PID 2>/dev/null | awk -F' = ' '{print $2}')"
      if [[ "$pid" =~ ^[0-9]+$ ]]; then
        printf '%s\n' "$pid"
        return 0
      fi
    fi
  fi

  if ! command -v i3-msg >/dev/null 2>&1 || ! command -v python3 >/dev/null 2>&1; then
    return 0
  fi

  i3-msg -t get_tree 2>/dev/null | python3 -c '
import json
import sys

try:
    tree = json.load(sys.stdin)
except Exception:
    raise SystemExit(0)

def find_focused_leaf(node):
    children = node.get("nodes", []) + node.get("floating_nodes", [])
    for child in children:
        result = find_focused_leaf(child)
        if result:
            return result
    if node.get("focused") and node.get("pid"):
        return node["pid"]
    return None

pid = find_focused_leaf(tree)
if pid:
    print(pid)
'
}

focused_tmux_client_tty() {
  local focused_pid=""
  local tmux_client_ttys=""
  local current_pid=""
  local child_pid=""
  local tty_short=""
  local -a queue=()

  if ! command -v tmux >/dev/null 2>&1 || ! command -v pgrep >/dev/null 2>&1; then
    return 0
  fi

  focused_pid="$(focused_window_pid || true)"
  [[ "$focused_pid" =~ ^[0-9]+$ ]] || return 0

  tmux_client_ttys="$(tmux list-clients -F "#{client_tty}" 2>/dev/null || true)"
  [[ -n "$tmux_client_ttys" ]] || return 0

  queue=("$focused_pid")
  while (( ${#queue[@]} > 0 )); do
    current_pid="${queue[0]}"
    queue=("${queue[@]:1}")

    [[ "$current_pid" =~ ^[0-9]+$ ]] || continue

    tty_short="$(ps -o tty= -p "$current_pid" 2>/dev/null | tr -d '[:space:]')"
    if [[ -n "$tty_short" && "$tty_short" != "?" ]]; then
      while IFS= read -r tty; do
        if [[ "$tty" == "/dev/$tty_short" ]]; then
          printf '/dev/%s\n' "$tty_short"
          return 0
        fi
      done <<< "$tmux_client_ttys"
    fi

    while IFS= read -r child_pid; do
      [[ -n "$child_pid" ]] || continue
      queue+=("$child_pid")
    done < <(pgrep -P "$current_pid" 2>/dev/null || true)
  done
}

active_tmux_pane() {
  local tty=""
  local pane=""
  local session=""

  tty="$(focused_tmux_client_tty || true)"
  if [[ -n "$tty" ]]; then
    pane="$(tmux display-message -p -c "$tty" "#{pane_id}" 2>/dev/null || true)"
    if [[ -n "$pane" ]]; then
      printf '%s\n' "$pane"
      return 0
    fi
  fi

  session="$(
    tmux list-clients -F "#{client_activity}\t#{client_session}" 2>/dev/null \
      | sort -rn \
      | awk -F '\t' 'NR == 1 { print $2 }'
  )"

  if [[ -n "$session" ]]; then
    tmux list-panes -t "$session" -F "#{pane_id} #{window_active} #{pane_active}" 2>/dev/null \
      | awk '$2 == "1" && $3 == "1" { print $1; exit }'
    return 0
  fi

  tmux list-panes -a -F "#{pane_id} #{window_active} #{pane_active}" 2>/dev/null \
    | awk '$2 == "1" && $3 == "1" { print $1; exit }'
}

cleanup_state() {
  rm -f "$STATE_FILE"
}

start_recording() {
  mkdir -p "$STATE_DIR"
  chmod 700 "$STATE_DIR" 2>/dev/null || true

  if [[ -f "$STATE_FILE" ]]; then
    # shellcheck disable=SC1090
    source "$STATE_FILE" || true
    if [[ -n "${PID:-}" ]] && kill -0 "$PID" 2>/dev/null; then
      exit 0
    fi
    cleanup_state
  fi

  local wav="$STATE_DIR/input.wav"
  local pane=""
  pane="$(active_tmux_pane || true)"

  rm -f "$wav" "$STATE_DIR/transcript.txt"

  local -a rec_cmd=(arecord -q -f S16_LE -r 16000 -c 1)
  if [[ -n "$PTT_ARECORD_DEVICE" ]]; then
    rec_cmd+=(-D "$PTT_ARECORD_DEVICE")
  fi
  rec_cmd+=("$wav")

  "${rec_cmd[@]}" >/dev/null 2>&1 &
  local pid=$!

  {
    printf 'PID=%q\n' "$pid"
    printf 'WAV=%q\n' "$wav"
    printf 'PANE=%q\n' "$pane"
  } > "$STATE_FILE"
}

stop_recording() {
  [[ -f "$STATE_FILE" ]] || exit 0

  # shellcheck disable=SC1090
  source "$STATE_FILE" || exit 0

  if [[ -n "${PID:-}" ]] && kill -0 "$PID" 2>/dev/null; then
    kill -INT "$PID" 2>/dev/null || true
    for _ in {1..40}; do
      if ! kill -0 "$PID" 2>/dev/null; then
        break
      fi
      sleep 0.03
    done
    kill -TERM "$PID" 2>/dev/null || true
  fi

  if [[ ! -s "${WAV:-}" ]]; then
    rm -f "${WAV:-}"
    cleanup_state
    exit 0
  fi

  if [[ ! -x "$WHISPER_BIN" || ! -f "$WHISPER_MODEL" ]]; then
    rm -f "$WAV"
    cleanup_state
    exit 1
  fi

  local out_prefix="$STATE_DIR/transcript"
  "$WHISPER_BIN" -m "$WHISPER_MODEL" -f "$WAV" -l en -otxt -of "$out_prefix" -np -nt >/dev/null 2>&1 || true

  local text=""
  local text_file="${out_prefix}.txt"
  if [[ -f "$text_file" ]]; then
    text="$(tr '\n' ' ' < "$text_file" | sed -E 's/[[:space:]]+/ /g; s/^ //; s/ $//')"
  fi

  if [[ -n "$text" ]]; then
    local target_pane=""
    target_pane="$(active_tmux_pane || true)"
    if [[ -z "$target_pane" ]]; then
      target_pane="${PANE:-}"
    fi

    if [[ -n "$target_pane" ]]; then
      tmux set-buffer -- "$text" >/dev/null 2>&1 || true
      tmux paste-buffer -d -t "$target_pane" >/dev/null 2>&1 || true
    elif command -v xdotool >/dev/null 2>&1; then
      xdotool type --clearmodifiers -- "$text" >/dev/null 2>&1 || true
    else
      printf '%s\n' "$text"
    fi
  fi

  rm -f "$WAV" "$text_file"
  cleanup_state
}

case "${1:-}" in
  start) start_recording ;;
  stop) stop_recording ;;
  *)
    echo "Usage: $0 {start|stop}" >&2
    exit 2
    ;;
esac
