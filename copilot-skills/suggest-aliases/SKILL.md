---
name: suggest-aliases
description: Suggest new bash aliases or functions for the user's bash profiles based on conversation history and patterns in existing profiles. Use when the user asks for alias suggestions, wants to improve their shell workflow, or says something like "suggest aliases" or "what should I add to my bash profile".
---

# Suggest Aliases

Your job is to analyze the user's existing bash profiles and recent conversation history, then
suggest useful aliases or functions — letting the user decide what to add and where.

## Step 1: Read the profiles

Always read both files before making any suggestions:

```bash
cat /srv/durable/esmongeski/skel/.bash_profile_addtl
cat /home/esmongeski/code/dotfiles/bashProfile.org
```

The `.bash_profile_addtl` is machine-local (personal overrides, one-off aliases).
The `bashProfile.org` is shared across all devices (generalizable utilities only).

## Step 2: Mine the current session first

**The primary source of suggestions is this Copilot session.** Look at what actually happened:
- Commands the user ran or asked about during the conversation
- Things that were slow, annoying, or required multiple steps
- Patterns like `cd X && do Y` that came up while solving a problem
- Flags or options the user had to look up or was shown for the first time
- Anything the user typed out manually that could have been shorter

Only after exhausting session-based suggestions should you look at recent session history in
`~/.copilot/session-state/` for additional context.

**Don't suggest things just because they seem generally useful** — the goal is to capture
friction points and patterns that surfaced organically in conversation, not to do a general
audit. If a suggestion isn't traceable to something that happened in the session, skip it.

## Step 3: Find generalizable patterns

Look for things in `.bash_profile_addtl` that:
- Could be parameterized into a function (e.g. `alias foo='cd ~/specific/path'` → `function goto() { cd "$1"; }`)
- Are device-specific but the pattern is general enough for `bashProfile.org`
- Could be combined (e.g. two aliases that always get used together)

Look for things in `bashProfile.org` that:
- Could be extended or improved based on how the user actually uses them
- Have workarounds in `.bash_profile_addtl` that suggest the shared version needs an update

## Step 4: Present suggestions interactively

For each suggestion:
1. Show the alias/function code
2. Explain briefly *why* — what pattern prompted it
3. Ask the user: **add it, skip it, or modify it?**
4. Ask **which file** — local (`.bash_profile_addtl`) or shared (`bashProfile.org`)

Use `ask_user` with choices for each decision. Don't batch everything up front — go one at a time
so the user can respond naturally without being overwhelmed.

## Step 5: Apply approved suggestions

When the user approves a suggestion:
- For `.bash_profile_addtl`: edit `/srv/durable/esmongeski/skel/.bash_profile_addtl` directly
- For `bashProfile.org`: edit `/home/esmongeski/code/dotfiles/bashProfile.org`, placing the new
  entry in the appropriate `* Section` heading (add a new heading if needed)

Group any new additions near related existing aliases/functions.

## What makes a good suggestion

**Good candidates (must be traceable to the session):**
- A long command with flags the user ran or was shown during the conversation
- A `cd` chain or multi-step sequence that came up while solving a problem
- Something the user said was slow, annoying, or had to look up
- A pattern that appeared 2+ times in the session
- Commands wrapped in `echoAndEval` patterns the user reached for

**Skip anything that:**
- Didn't come up in the session — no "these seem generally useful" suggestions
- Already exists in either profile (check both files first!)
- Is too specific to a one-time task with no reuse value
- Shadows a system command in a confusing way

## Format for aliases vs functions

Prefer a **function** over an alias when:
- The command takes arguments
- The logic has more than one step
- You want to use variables or conditionals

Prefer an **alias** when:
- It's a simple shorthand for a fixed command with flags
- No arguments needed

```bash
# alias — simple shorthand
alias gs='git status'

# function — takes args or has logic
function cds() { cd "$CORE/$1"; }
```
