import { writeFile } from "node:fs/promises"
import { basename } from "node:path"

const DEDUPE_MS = 1000
const ISSUE_ID_PATTERN = /\b[A-Z][A-Z0-9]+-\d+\b/
const ISSUE_WINDOW_PREFIX = "opencode - "

export const TmuxNotifyPlugin = async ({ $, project, directory, worktree }) => {
  const pane = process.env.TMUX_PANE || ""
  const inTmux = Boolean(process.env.TMUX && pane)
  const lastNotifiedAt = new Map()
  let activeIssueID = ""
  let baseWindowName = "opencode"
  let baseAutomaticRename = "on"
  let windowStateLoaded = false
  const projectName = project?.name || basename(worktree || directory || "") || "project"

  const issueWindowName = (issueID) => `${ISSUE_WINDOW_PREFIX}${projectName} - ${issueID}`

  const extractIssueID = (value) => {
    if (!value) {
      return ""
    }

    if (typeof value === "string") {
      return value.match(ISSUE_ID_PATTERN)?.[0] || ""
    }

    if (Array.isArray(value)) {
      for (const item of value) {
        const issueID = extractIssueID(item)
        if (issueID) {
          return issueID
        }
      }
      return ""
    }

    if (typeof value === "object") {
      for (const key of ["issueId", "id", "identifier", "query", "title", "text"]) {
        if (key in value) {
          const issueID = extractIssueID(value[key])
          if (issueID) {
            return issueID
          }
        }
      }

      for (const nestedValue of Object.values(value)) {
        const issueID = extractIssueID(nestedValue)
        if (issueID) {
          return issueID
        }
      }
    }

    return ""
  }

  const ensureWindowState = async () => {
    if (!inTmux || windowStateLoaded) {
      return
    }

    try {
      const windowName = (await $`tmux display-message -p -t ${pane} "#{window_name}"`.text()).trim()
      if (windowName) {
        baseWindowName = windowName.startsWith(ISSUE_WINDOW_PREFIX) ? `opencode - ${projectName}` : windowName
      }
    } catch {}

    try {
      const automaticRename = (await $`tmux show-window-options -v -t ${pane} automatic-rename`.text()).trim()
      if (automaticRename === "on" || automaticRename === "off") {
        baseAutomaticRename = automaticRename
      }
    } catch {}

    windowStateLoaded = true
  }

  const setIssueWindowName = async (issueID) => {
    if (!inTmux || !issueID || activeIssueID === issueID) {
      return
    }

    await ensureWindowState()

    try {
      await $`tmux set-window-option -t ${pane} automatic-rename off`
    } catch {}

    try {
      await $`tmux rename-window -t ${pane} ${issueWindowName(issueID)}`
      activeIssueID = issueID
    } catch {}
  }

  const restoreWindowName = async () => {
    if (!inTmux || !activeIssueID) {
      return
    }

    await ensureWindowState()

    try {
      await $`tmux rename-window -t ${pane} ${baseWindowName}`
    } catch {}

    try {
      await $`tmux set-window-option -t ${pane} automatic-rename ${baseAutomaticRename}`
    } catch {}

    activeIssueID = ""
  }

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
    "chat.message": async (_input, output) => {
      const issueID = extractIssueID(output.parts)
      if (issueID) {
        await setIssueWindowName(issueID)
      }
    },
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        await restoreWindowName()
        await notifyTmux("done")
      }

      if (event.type === "permission.asked" || event.type === "permission.replied" || event.type === "permission.updated") {
        await notifyTmux("input")
      }
    },
    "tool.execute.before": async (input, output) => {
      if (input.tool.startsWith("linear_")) {
        const issueID = extractIssueID(output.args)
        if (issueID) {
          await setIssueWindowName(issueID)
        }
      }

      if (input.tool === "question") {
        await notifyTmux("input")
      }
    },
  }
}

export default TmuxNotifyPlugin
