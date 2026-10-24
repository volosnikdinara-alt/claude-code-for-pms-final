#!/usr/bin/env bash
# Read-only checkup for the Claude Code for PMs course setup.
# Changes nothing. Safe to run at any time, on Mac or on Windows (Git Bash).

REPO_NAME="claude-code-for-pms-final"
REPO_DIR="$HOME/$REPO_NAME"

# Never let git block waiting for a password that cannot be typed here.
export GIT_TERMINAL_PROMPT=0
export GIT_ASKPASS=echo

line() { printf '\n--- %s ---\n' "$1"; }

line "GIT INSTALLED"
if command -v git >/dev/null 2>&1; then
  git --version
else
  echo "RESULT: git-missing"
  echo "Nothing else can be checked until git is installed."
  exit 0
fi

line "COURSE FOLDER"
if [ -d "$REPO_DIR" ]; then
  echo "Found: $REPO_DIR"
  if [ -d "$REPO_DIR/.git" ]; then
    echo "Tracked by git: yes"
  else
    echo "Tracked by git: NO (folder exists but git knows nothing about it)"
    echo "RESULT: folder-not-a-repo"
  fi
else
  echo "Not found at $REPO_DIR"
  echo "Searching elsewhere in the home folder (may take a moment)..."
  find "$HOME" -maxdepth 4 -type d -name "$REPO_NAME" -not -path '*/.*' 2>/dev/null | head -5
  echo "RESULT: no-folder-at-expected-path"
fi

if [ ! -d "$REPO_DIR/.git" ]; then
  line "END"
  echo "Stopping here: no working course folder to inspect."
  exit 0
fi

cd "$REPO_DIR" || exit 0

line "GITHUB ADDRESS"
git remote -v || echo "No GitHub address set."

line "COURSE FILES PRESENT"
for d in 00-rook 01-origin-story 06-sidekicks CLAUDE.md README.md; do
  if [ -e "$d" ]; then echo "ok   $d"; else echo "MISSING $d"; fi
done

line "BRANCH AND UNSAVED CHANGES"
git status -sb

line "RECENT SAVES"
git log --oneline -5 2>/dev/null || echo "No saves yet."

line "IDENTITY FOR SAVING"
echo "name:  $(git config user.name)"
echo "email: $(git config user.email)"

line "IS THE GITHUB COPY REACHABLE AND PUBLIC"
REMOTE_URL="$(git config --get remote.origin.url)"
if [ -n "$REMOTE_URL" ]; then
  case "$REMOTE_URL" in
    *Product-School-Platform*|*-template*)
      echo "RESULT: remote-points-at-template"
      echo "This folder is pointed at the shared course template, not the student's own copy." ;;
  esac
  case "$REMOTE_URL" in
    git@*) echo "RESULT: remote-uses-ssh" ;;
  esac
  if git ls-remote "$REMOTE_URL" >/dev/null 2>&1; then
    echo "Reachable without signing in: yes (repository is public)"
  else
    echo "Reachable without signing in: no (private, missing, wrong address, or offline)"
  fi
else
  echo "RESULT: no-remote"
  echo "No address to check."
fi

line "SIGN-IN TEST (no files are sent)"
PUSH_OUT="$(git push --dry-run 2>&1)"
PUSH_STATUS=$?
echo "$PUSH_OUT" | tail -5
if [ "$PUSH_STATUS" -eq 0 ]; then
  echo "RESULT: sign-in-ok"
else
  echo "RESULT: sign-in-failed — the reason is in the lines above"
fi

line "END"
