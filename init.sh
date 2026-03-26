#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "$0")" && pwd)"
emacs_dir="${HOME}/.emacs.d"

mkdir -p "${emacs_dir}"
cp "${repo_dir}/early-init.el" "${emacs_dir}/early-init.el"

cat > "${emacs_dir}/init.el" <<EOF
(setenv "PATH_TO_DOTFILES_REPO" "${repo_dir}")
(load-file (expand-file-name ".emacs" (getenv "PATH_TO_DOTFILES_REPO")))
EOF
