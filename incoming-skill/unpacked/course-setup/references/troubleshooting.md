# Troubleshooting

Find the matching section, read only that one, fix it, then re-run the checkup
to prove it's fixed. If two sections look like they apply, work the one earlier
in this file first.

Before any repair that touches files, commit whatever is in the folder so
nothing can be lost:

```bash
cd ~/claude-code-for-pms-final 2>/dev/null && git add -A && git commit -m "Save work before setup repair" || true
```

## Contents

1. Git isn't installed
2. Mac asks for developer tools
3. The folder is already there
4. The folder isn't connected to GitHub
5. They downloaded a ZIP instead of cloning
6. Their GitHub copy is empty or missing the course files
7. Saving to GitHub fails
8. Signed in as the wrong GitHub account
9. The address uses SSH instead of HTTPS
10. Git wants to know who they are
11. The line of work has the wrong name, or GitHub doesn't know about it
12. Their work isn't attached to the main line
13. Nothing to save, but I did work
14. It saved, but it isn't on GitHub
15. The repository is private and the instructor can't see it
16. Claude Code has the wrong folder open
17. There are two copies of the course folder
18. Warnings about line endings on Windows
19. GitHub is unreachable

---

## 1. Git isn't installed

**Symptom:** `git: command not found`, or the checkup says `git-missing`.

**Mac:** git comes with Apple's command line tools — see section 2.

**Windows:** the Claude app's Code tab needs Git for Windows. Tell them:

> Download Git from https://git-scm.com/downloads/win and install it, taking
> the default options on every screen. Then quit the Claude app completely and
> open it again — it only notices Git at startup. Come back here and tell me
> when that's done.

The restart matters. If they say they installed it and git still isn't found,
the app almost certainly wasn't fully quit.

---

## 2. Mac asks for developer tools

**Symptom:** a popup offering to install "command line developer tools", or an
error mentioning `xcrun` or an invalid developer path.

Tell them:

> Click **Install** on that popup and let it finish — it takes a few minutes.
> If there's no popup, press Cmd+Space, type `Terminal`, press Enter, paste
> `xcode-select --install` and press Enter. Tell me when it's done.

Then retry whatever failed. This is a one-time thing.

---

## 3. The folder is already there

**Symptom:** cloning fails saying the destination path already exists and is
not empty.

They already have the folder. Do not delete it, and do not clone over it —
their work may be inside. Find out what it is:

```bash
ls -a ~/claude-code-for-pms-final
git -C ~/claude-code-for-pms-final remote -v
git -C ~/claude-code-for-pms-final log --oneline -5
```

- Correct address, course files present → nothing to fix. Tell them it was
  already set up, and move on to the sign-in test.
- Folder present but no `.git` → section 4.
- Nearly empty and no work in it → safe to move aside and start fresh:

```bash
mv ~/claude-code-for-pms-final ~/claude-code-for-pms-final-old
```

Tell them you moved the old empty folder aside rather than deleting it, and
they can throw away `claude-code-for-pms-final-old` later.

---

## 4. The folder isn't connected to GitHub

**Symptom:** the folder exists, has course files, but there's no `.git` inside,
or `git remote -v` prints nothing.

The files are fine; git just doesn't know where they belong. Connect them
without touching their work.

If `.git` is missing entirely:

```bash
cd ~/claude-code-for-pms-final && git init -b main && git remote add origin https://github.com/USERNAME/claude-code-for-pms-final.git && git add -A && git commit -m "My course work"
GIT_TERMINAL_PROMPT=0 git -C ~/claude-code-for-pms-final push -u origin main
```

If only the address is missing:

```bash
git -C ~/claude-code-for-pms-final remote add origin https://github.com/USERNAME/claude-code-for-pms-final.git
```

If the push complains that the two copies have unrelated histories, their
GitHub copy has the template files and their computer copy is a separate
starting point. Bring them together once:

```bash
cd ~/claude-code-for-pms-final && GIT_TERMINAL_PROMPT=0 git pull origin main --allow-unrelated-histories --no-rebase
```

Resolve any conflicts with the student as described in `saving-work.md`, then
push.

---

## 5. They downloaded a ZIP instead of cloning

**Symptom:** the folder is named something like `claude-code-for-pms-final-main`,
there's no `.git` inside, and they mention downloading and unzipping.

The files are real work; only the connection is missing. Treat it as section 4,
but rename the folder first so the rest of the course matches the instructions:

```bash
mv ~/claude-code-for-pms-final-main ~/claude-code-for-pms-final
```

---

## 6. Their GitHub copy is empty or missing the course files

**Symptom:** the folder downloads fine but has almost nothing in it, or their
GitHub page shows only a README.

Their repository was created empty rather than from the course template. Tell
them:

> Your copy on GitHub was made without the course files. The quickest fix is to
> make it again from the template. Go to
> https://github.com/new?template_name=claude-code-for-pms-template&template_owner=Product-School-Platform
> — check that the box at the top says
> `Product-School-Platform/claude-code-for-pms-template`, name it
> `claude-code-for-pms-final-2`, leave it Public, and create it. Tell me when
> it's there and I'll set up the folder on your computer.

Use the new name throughout, and tell them to delete the empty one on GitHub
(Settings → scroll to the bottom → Delete this repository) and rename the good
one to `claude-code-for-pms-final` afterwards, so grading finds it.

If they already have work in the empty version, copy their files into the new
folder before pushing, and say that's what you did.

---

## 7. Saving to GitHub fails

**Symptom:** any of —

- "could not read Username for 'https://github.com': terminal prompts disabled"
- "Support for password authentication was removed"
- "Authentication failed"
- "remote: Permission to ... denied"
- "fatal: repository not found" on a repository you know exists

All of these mean the same thing in plain terms: **GitHub doesn't know it's
them.** Either they've never done the one-time sign-in, or it has expired
(Mac tokens last 90 days), or it's stored for the wrong account (section 8).

You cannot do this step for them — it needs a password typed where nobody can
read it. Send the instructions for their computer from
`first-time-setup.md` step 7, then wait, then verify with:

```bash
GIT_TERMINAL_PROMPT=0 git -C ~/claude-code-for-pms-final push --dry-run
```

If it fails again with the same message after a fresh token, the old sign-in is
probably cached and being reused. That needs clearing, which is also theirs to
run:

**Mac:**

```
git credential-osxkeychain erase
host=github.com
protocol=https

```
(they press Enter twice on the blank line at the end, then do the sign-in again)

**Windows:**

```
cmdkey /list:git:https://github.com
cmdkey /delete:git:https://github.com
```
(then `git push` again to trigger the browser sign-in)

Explain it as "clearing the old sign-in so GitHub asks fresh", not as credential
management.

---

## 8. Signed in as the wrong GitHub account

**Symptom:** "Permission to SOMEONE-ELSE/claude-code-for-pms-final.git denied to
THEIR-NAME", or the reverse.

Two things to check, in this order:

```bash
git -C ~/claude-code-for-pms-final remote -v
```

If the address has someone else's username in it — a classmate's, or the
Product School organization — they cloned the wrong copy. Point it at theirs:

```bash
git -C ~/claude-code-for-pms-final remote set-url origin https://github.com/USERNAME/claude-code-for-pms-final.git
```

If the address is right, the stored sign-in belongs to a different GitHub
account (common when a work account is already saved on the machine). Clear it
using the commands in section 7 and sign in again with the account that owns
the repository.

A Mac token also fails this way if it was scoped to the wrong repository. The
token needs **Repository access → Only select repositories →
claude-code-for-pms-final**, and **Contents: Read and write**. If theirs was set
up differently, they make a new one.

---

## 9. The address uses SSH instead of HTTPS

**Symptom:** "Permission denied (publickey)", or the address starts with
`git@github.com:`.

This course uses the web address form throughout. Switch it:

```bash
git -C ~/claude-code-for-pms-final remote set-url origin https://github.com/USERNAME/claude-code-for-pms-final.git
```

Then do the sign-in test. Don't explain SSH keys — it's a dead end for this
course.

---

## 10. Git wants to know who they are

**Symptom:** "Author identity unknown", or "Please tell me who you are".

Set it without asking for a personal email — GitHub provides a private
forwarding address:

```bash
git -C ~/claude-code-for-pms-final config user.name "USERNAME"
git -C ~/claude-code-for-pms-final config user.email "USERNAME@users.noreply.github.com"
```

Then retry the save. Mention only that you've labeled their saves with their
GitHub name.

---

## 11. The line of work has the wrong name, or GitHub doesn't know about it

**Symptom:** "fatal: The current branch has no upstream branch", or their
computer says `master` while GitHub shows `main`.

Check:

```bash
git -C ~/claude-code-for-pms-final branch --show-current
```

If it's `main`, just connect it:

```bash
cd ~/claude-code-for-pms-final && GIT_TERMINAL_PROMPT=0 git push -u origin main
```

If it's `master`, rename it so everything matches the course instructions:

```bash
cd ~/claude-code-for-pms-final && git branch -m main && GIT_TERMINAL_PROMPT=0 git push -u origin main
```

To the student this is just "your work and GitHub were using different names
for the same thing — fixed."

---

## 12. Their work isn't attached to the main line

**Symptom:** `git status` says "HEAD detached", or the checkup shows no branch
name.

Their saves are real but floating. Rescue them onto the main line:

```bash
cd ~/claude-code-for-pms-final && git add -A && git commit -m "Save work before setup repair" || true
cd ~/claude-code-for-pms-final && git branch rescue-work && git switch main && git merge rescue-work
GIT_TERMINAL_PROMPT=0 git -C ~/claude-code-for-pms-final push
```

If `git switch main` fails because there is no `main`, use whatever branch
GitHub has, or create it: `git switch -c main`.

Never discard the detached work to "clean things up" — that is the work.

---

## 13. Nothing to save, but I did work

**Symptom:** the save says there's nothing to commit, but the student is sure
they did something.

Check, in order:

```bash
git -C ~/claude-code-for-pms-final status -sb
git -C ~/claude-code-for-pms-final log --oneline -5
git -C ~/claude-code-for-pms-final check-ignore -v 05-super-speed/* 2>/dev/null
ls -la ~/claude-code-for-pms-final
```

Likely causes:

- It was already saved a moment ago. Show them the most recent save and its
  time.
- The work happened in a different folder — a session opened somewhere else.
  Ask what folder was showing in the Code tab, and look there.
- The file is being ignored (rare, but check output files and anything with a
  build-like name). If a course file is genuinely ignored, add it explicitly
  with `git add -f <file>` and tell them what you did.

---

## 14. It saved, but it isn't on GitHub

**Symptom:** the save worked, the page on GitHub doesn't show it.

```bash
git -C ~/claude-code-for-pms-final log --oneline -3
GIT_TERMINAL_PROMPT=0 git -C ~/claude-code-for-pms-final push
git -C ~/claude-code-for-pms-final status -sb
```

The status line tells you if local saves haven't been sent yet ("ahead by N").
Push them. If it now says "Everything up-to-date" and the page still looks
empty, they are probably looking at a different repository — ask them to paste
the address from their browser and compare it to the one in `git remote -v`.
Also worth checking: GitHub shows the default branch. If their work went to a
differently named line of work, section 11 covers it.

---

## 15. The repository is private and the instructor can't see it

The setup guide asks for **Public**, because nothing in the course materials is
sensitive and grading is simpler. If the checkup reported the repository isn't
reachable without signing in, tell them:

> Open https://github.com/USERNAME/claude-code-for-pms-final/settings, scroll
> to the bottom, and under "Change repository visibility" choose **Public**.
> GitHub will ask you to type the repository name to confirm.

If they'd rather keep it private, that's their call — but they need to add
their instructor as a collaborator, and they should raise it in the cohort
channel so grading knows.

---

## 16. Claude Code has the wrong folder open

**Symptom:** files the student expects aren't visible, or work landed somewhere
unexpected.

```bash
pwd
git rev-parse --show-toplevel 2>/dev/null
```

If that isn't `~/claude-code-for-pms-final`, tell them:

> This session is pointed at a different folder. Click **+ New session** in the
> Code tab and choose `claude-code-for-pms-final` under Project folder. Every
> session in this course uses that same folder.

Don't move their files to make the current session work. Move the session.

---

## 17. There are two copies of the course folder

**Symptom:** the checkup's search turned up more than one
`claude-code-for-pms-final`.

Work out which one has the real work:

```bash
for d in <each path found>; do echo "== $d"; git -C "$d" log --oneline -3 2>/dev/null; git -C "$d" status -s 2>/dev/null | head; done
```

Keep the one in the home folder with the most recent work. If the other one has
work too, copy those files across rather than picking one and losing the other,
then rename the loser out of the way:

```bash
mv <other-path> <other-path>-old
```

Tell the student plainly which folder is now the real one, and that they should
pick that one as the Project folder from now on.

---

## 18. Warnings about line endings on Windows

**Symptom:** "warning: LF will be replaced by CRLF".

Harmless. Don't act on it, and don't mention it unless they ask — then say it's
a note about how Windows stores line breaks and it doesn't affect their work.

---

## 19. GitHub is unreachable

**Symptom:** timeouts, "could not resolve host", proxy or certificate errors.

Usually a corporate network or VPN. Check:

```bash
GIT_TERMINAL_PROMPT=0 git ls-remote https://github.com/Product-School-Platform/claude-code-for-pms-template.git >/dev/null 2>&1 && echo REACHABLE || echo BLOCKED
```

If blocked, tell them GitHub appears to be blocked on their current network,
suggest trying off the VPN or on a home or phone connection, and say it's worth
flagging in the cohort channel since employer-managed laptops sometimes need an
exception. Don't attempt proxy configuration.
