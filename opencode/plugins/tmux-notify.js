import { writeFile } from "node:fs/promises"

const DEDUPE_MS = 1000

export const TmuxNotifyPlugin = async ({ $ }) => {
  const pane = process.env.TMUX_PANE || ""
  const inTmux = Boolean(process.env.TMUX && pane)
  const lastNotifiedAt = new Map()

  const recentlyNotified = (key) => {
    const now = Date.now()
    const previous = lastNotifiedAt.get(key) || 0
    if (now - previous < DEDUPE_MS) {
      return true
    }
    lastNotifiedAt.set(key, now)
    return false
  }

  const notifyTmux = async (key) => {
    if (!inTmux || recentlyNotified(key)) {
      return
    }

    try {
      await $`tmux set-window-option -t ${pane} monitor-bell on`
    } catch {}

    try {
      const paneTty = (await $`tmux display-message -p -t ${pane} "#{pane_tty}"`.text()).trim()
      if (paneTty) {
        await writeFile(paneTty, "\x07")
      }
    } catch {}

  }

  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        await notifyTmux("done")
      }

      if (event.type === "permission.asked" || event.type === "permission.updated") {
        await notifyTmux("input")
      }
    },
    "tool.execute.before": async (input) => {
      if (input.tool === "question") {
        await notifyTmux("input")
      }
    },
  }
}

export default TmuxNotifyPlugin
