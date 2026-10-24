---
name: course-setup
description: Set up, check, and repair the GitHub repository for Product School's "Claude Code for PMs" course. Use this whenever the student wants to get the course folder onto their computer, save their work to GitHub, or is stuck on anything involving GitHub, git, cloning, pushing, signing in, tokens, or the claude-code-for-pms-final repository. Trigger on vague reports too — "my work isn't showing up", "it says permission denied", "did that save?", "I don't think this worked", "my folder looks empty", "GitHub is asking for a password" — and trigger even when the student never says the words git or GitHub. Always use this skill rather than improvising git commands, because the recovery order here protects work the student has already done.
---

# Course setup and repair

This skill gets a Product School "Claude Code for PMs" student from nothing to a
working course folder on their computer that saves reliably to GitHub, and
rescues them when any part of that breaks.

The student is an experienced product manager with essentially no developer
tooling experience. They are not going to debug anything. Their entire model of
this system is: *my work lives in a folder, and it needs to end up on a website
so my instructor can see it.* Keep that model intact.

## How to talk to the student

- Plain English. Never say repository, commit, remote, upstream, branch, HEAD,
  rebase, or origin unless you immediately say what it means in ordinary words.
  "Folder", "save", "the copy on GitHub", "your work" all work fine.
- Never paste a raw git error at them. Read it yourself, then tell them what
  happened and what you're doing about it.
- Do the work. Do not hand them a list of commands to run unless the step
  genuinely cannot be done from here — which is true for exactly one thing, the
  one-time sign-in in Part 5 of their setup guide, because it needs them to type
  a password.
- One instruction at a time. If they need to do something in a browser or a
  terminal, give them that one thing and wait.
- End every run by telling them plainly whether they are set up or not, and
  what happens next.

## Hard rules

- **Never ask the student to paste a GitHub token, password, or any credential
  into this chat, and never read one back to them.** Tokens are typed into the
  terminal's password prompt, where nothing displays them. If you find a token
  in the chat or in a file, tell them to delete that token on GitHub and make a
  new one, and do not use it.
- **Never run a command that can lose work without saying what it will do and
  getting a clear yes.** That includes `git reset --hard`, `git checkout -- .`,
  `git clean`, `git restore`, deleting a folder, and any force push. Before any
  repair that touches files, save their current state first (see
  "Protect the work first" below).
- **Always prefix network git commands with `GIT_TERMINAL_PROMPT=0`.** Without
  it, git will sit waiting for a password that can never be typed here, and the
  session hangs. With it, git fails immediately and you get a readable error.
- Never re-clone over a folder that has the student's work in it. Repair the
  folder you have.
- The course folder is `claude-code-for-pms-final`, it lives in the student's
  home folder, and its address on GitHub is
  `https://github.com/<their-username>/claude-code-for-pms-final`.

## Protect the work first

Before any repair beyond a plain check, if the folder exists and has changes in
it, commit them. A commit is a save point; nothing later can lose work that has
been committed. Do it quietly, without narrating the mechanics:

```bash
cd ~/claude-code-for-pms-final 2>/dev/null && git add -A && git commit -m "Save work before setup repair" || true
```

Then say something like "I've saved a snapshot of your work first, so nothing
here can lose it."

## Step 1 — Always start with the checkup

Run the bundled script. It only reads; it changes nothing.

```bash
bash "$CLAUDE_SKILL_DIR/scripts/checkup.sh"
```

If that path isn't set in this session, run `scripts/checkup.sh` from wherever
this skill folder lives. If the script will not run at all, gather the same
picture by hand:

```bash
git --version
ls -d ~/claude-code-for-pms-final
cd ~/claude-code-for-pms-final && git remote -v && git status -sb && git log --oneline -3
GIT_TERMINAL_PROMPT=0 git -C ~/claude-code-for-pms-final push --dry-run
```

## Step 2 — Route on what the checkup says

| What the checkup shows | Where to go |
|---|---|
| Git isn't installed | `references/troubleshooting.md` → "Git isn't installed" |
| No course folder on this computer | `references/first-time-setup.md` |
| Folder exists but isn't tracked by git, or has no address on GitHub | `references/troubleshooting.md` → "The folder isn't connected to GitHub" |
| `remote-points-at-template` — folder points at the shared course template | `references/troubleshooting.md` → "Signed in as the wrong GitHub account" |
| `remote-uses-ssh` | `references/troubleshooting.md` → "The address uses SSH instead of HTTPS" |
| Folder is fine, sign-in test failed | `references/troubleshooting.md` → "Saving to GitHub fails" |
| Folder is fine, sign-in test passed, student wants to save | `references/saving-work.md` |
| Everything passes and they just wanted a check | Report the ready checklist below and stop |

Read only the reference file you need. Each one is self-contained.

## Step 3 — Finish with the ready check

Whatever route you took, end by confirming these five things and saying which
ones are true. This mirrors the checklist in the student's setup guide, so it
is the wording they already recognize:

1. The Claude app is installed and the Code tab opens.
2. They have a GitHub account they can sign in to.
3. `github.com/<username>/claude-code-for-pms-final` opens in a browser and
   shows the course files.
4. A folder named `claude-code-for-pms-final` is on their computer.
5. Saving to GitHub works without asking them to sign in again.

If all five are true, tell them they're set and that from now on saving is one
sentence pasted at the end of each session. If something is still open, say
exactly which one and what the next single action is.

## What "success" looks like at the end of a session

The student pastes the closing prompt from the slides, and their work appears
at their GitHub address. If they ask you to save their work, that is
`references/saving-work.md` — always confirm afterwards by giving them the
clickable link to their repository and telling them what they should see there.

## Reference files

- `references/first-time-setup.md` — getting the folder onto the computer for
  the first time, and the one-time sign-in.
- `references/saving-work.md` — the end-of-session save, and confirming it
  landed.
- `references/troubleshooting.md` — symptom-by-symptom repairs. Read the
  matching section only.
