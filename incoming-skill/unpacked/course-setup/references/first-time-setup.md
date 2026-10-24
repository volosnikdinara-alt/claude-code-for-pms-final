# First-time setup

Goal: a folder named `claude-code-for-pms-final` in the student's home folder,
holding the course files, connected to their own copy on GitHub, and able to
save without asking them to sign in again.

Work through these in order. Skip anything the checkup already proved.

## 1. Check you can work in the right place

The folder has to land in the student's home folder
(`/Users/<name>` on Mac, `C:\Users\<name>` on Windows).

If this session can't create files there — it refuses, or asks about working
outside the current folder — stop and tell the student:

> Quit this session and start a new one. In the Claude app, Code tab,
> click **+ New session**, and for **Project folder** pick your home folder —
> the one with your name on it. Then paste your question again.

Don't try to work around it. A clone in the wrong place causes confusing
problems for the rest of the course.

## 2. Get their GitHub username

Ask once, plainly: "What's your GitHub username? It's the name in the address
of your repository — `github.com/`**`this-part`**`/claude-code-for-pms-final`."

If they don't know it, tell them to open github.com, click their picture in the
top right, and read the name under "Signed in as".

## 3. Confirm their copy exists on GitHub before downloading it

```bash
GIT_TERMINAL_PROMPT=0 git ls-remote https://github.com/USERNAME/claude-code-for-pms-final.git >/dev/null 2>&1 && echo FOUND || echo NOT-FOUND
```

**FOUND** — go to step 4.

**NOT-FOUND** — one of three things, and you can't tell which from here, so ask
them to check in this order:

1. They haven't made their copy yet. That's Part 3 of the setup guide: while
   signed in to GitHub, open
   `https://github.com/new?template_name=claude-code-for-pms-template&template_owner=Product-School-Platform`,
   type the name `claude-code-for-pms-final` exactly, leave it **Public**, and
   click the green **Create repository** button.
2. The username is spelled differently than they told you.
3. They named the folder something else on GitHub. Ask them to paste the web
   address of their repository and use that name instead — but tell them the
   grading instructions expect `claude-code-for-pms-final`, so renaming it on
   GitHub (Settings → Repository name) is the tidier fix.

## 4. Download the folder to their computer

```bash
cd ~ && GIT_TERMINAL_PROMPT=0 git clone https://github.com/USERNAME/claude-code-for-pms-final.git
```

- If it fails with something about developer tools or `xcrun` on a Mac, see
  `troubleshooting.md` → "Mac asks for developer tools".
- If it says the destination already exists, do **not** delete anything. Go to
  `troubleshooting.md` → "The folder is already there".

## 5. Check what arrived

```bash
ls ~/claude-code-for-pms-final
```

They should see `00-rook`, six numbered module folders, `CLAUDE.md` and
`README.md`. If the folder is nearly empty, their GitHub copy was made without
the course files — send them back to step 3, option 1, making sure the template
box at the top of the GitHub page says
`Product-School-Platform/claude-code-for-pms-template`.

## 6. Set the name their saves are labeled with

Only if the checkup showed these empty. Use their GitHub username and GitHub's
private forwarding address, so you never have to ask for a personal email:

```bash
git -C ~/claude-code-for-pms-final config user.name "USERNAME"
git -C ~/claude-code-for-pms-final config user.email "USERNAME@users.noreply.github.com"
```

## 7. The one-time sign-in — this part is theirs to do

This is the only step you cannot do for them, and the reason is worth saying
out loud: it needs a password typed somewhere that no one, including you, can
read it.

Test first, so you don't send them off for nothing:

```bash
GIT_TERMINAL_PROMPT=0 git -C ~/claude-code-for-pms-final push --dry-run
```

If that succeeds, they are already signed in — skip to step 8.

If it fails, hand them the instructions for their computer, in one message, and
then wait.

**Mac** — they need a sign-in token first. Tell them:

> Two parts, about three minutes.
>
> **First, make a sign-in token.** Open
> https://github.com/settings/personal-access-tokens/new and fill in:
> - Token name: `Claude Code course`
> - Expiration: 90 days
> - Repository access: "Only select repositories" → choose `claude-code-for-pms-final`
> - Permissions → Repository permissions → Contents: "Read and write"
>
> Click **Generate token** and copy it. Don't paste it here — it goes in the
> terminal in a moment, and I never need to see it.
>
> **Then sign in once.** Press Cmd+Space, type `Terminal`, press Enter, and
> paste these two lines, pressing Enter after each:

```
cd claude-code-for-pms-final
git push
```

> When it asks for a username, type your GitHub username. When it asks for a
> password, paste the token. Nothing appears while you paste — that's normal.
> Press Enter. It should say "Everything up-to-date". Tell me when you're done.

**Windows** — no token needed:

> Press the Windows key, type `PowerShell`, press Enter, and paste these two
> lines, pressing Enter after each:

```
cd claude-code-for-pms-final
git push
```

> A browser window opens — sign in to GitHub there, then come back. It should
> say "Everything up-to-date". Tell me when you're done.

When they report back, verify rather than take their word for it:

```bash
GIT_TERMINAL_PROMPT=0 git -C ~/claude-code-for-pms-final push --dry-run
```

Still failing? Go to `troubleshooting.md` → "Saving to GitHub fails".

## 8. Confirm and hand over

Run the ready check from SKILL.md. Then tell them:

- The folder to pick as **Project folder** for every session in this course is
  `claude-code-for-pms-final`.
- Saving is one sentence pasted at the end of each session, and you'll handle
  the rest.
