# Saving work to GitHub

This runs at the end of every session. It should take one exchange and end with
a link the student can click.

## The sequence

Work inside `~/claude-code-for-pms-final`.

1. **See what changed**, so your description of the save is honest:

```bash
git -C ~/claude-code-for-pms-final status -sb
```

2. **Save everything locally**, with a short message describing what the
   session actually did — the module worked on, what was written. Not "update
   files".

```bash
cd ~/claude-code-for-pms-final && git add -A && git commit -m "Module 2: notes from the interviews and tickets"
```

If it says nothing to commit, don't invent a save. Check whether the work went
somewhere else — see `troubleshooting.md` → "Nothing to save, but I did work".

3. **Send it to GitHub:**

```bash
cd ~/claude-code-for-pms-final && GIT_TERMINAL_PROMPT=0 git push
```

4. **Confirm.** Tell them it's done and give them the clickable link:

> Saved. Your work is at
> https://github.com/USERNAME/claude-code-for-pms-final — open it and you'll
> see your files with the time you saved next to them.

## When the push is rejected

The usual cause is that the copy on GitHub has something the computer's copy
doesn't — often because they edited a file in the GitHub website, or worked on
a second computer.

Their work is already committed at this point, so bringing the two together is
safe:

```bash
cd ~/claude-code-for-pms-final && GIT_TERMINAL_PROMPT=0 git pull --rebase && GIT_TERMINAL_PROMPT=0 git push
```

If that stops on a conflict — the same file changed in both places — do not
guess. Stop, and:

```bash
git -C ~/claude-code-for-pms-final rebase --abort
cd ~/claude-code-for-pms-final && GIT_TERMINAL_PROMPT=0 git pull --no-rebase
```

Then open the conflicted file, show the student both versions in plain
language, ask which they want to keep or whether to keep both, make the edit
yourself, and save again. Never resolve a conflict silently.

## When the sign-in has expired

On a Mac the sign-in token lasts 90 days, so this surfaces mid-course. The
symptom is a push that fails talking about authentication or permissions. Send
them to `troubleshooting.md` → "Saving to GitHub fails" — the fix is a new
token and a one-time terminal sign-in, the same as setup.

## What not to do

- Don't push with `--force`. There is no situation in this course that needs it,
  and it can erase work.
- Don't create branches. Everything in this course lives on one line of work.
- Don't add or change `.gitignore` to make something save. If a file won't
  save, find out why first.
