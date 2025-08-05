#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Starting Mac setup…"

# Helper: backup a file or directory if it exists
backup() {
  local target="$1"
  if [ -e "$target" ] || [ -d "$target" ]; then
    local ts
    ts="$(date +%Y%m%d%H%M%S)"
    local dest="${target}.backup.${ts}"
    echo "⏳ Backing up $target → $dest"
    mv "$target" "$dest"
  fi
}

# 1) Xcode Command Line Tools
if ! xcode-select -p >/dev/null 2>&1; then
  echo "→ Installing Xcode Command Line Tools…"
  xcode-select --install
  until xcode-select -p >/dev/null 2>&1; do sleep 5; done
  echo "✔️  Xcode CLT installed."
else
  echo "✔️  Xcode CLT already present."
fi

# 2) Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "→ Installing Homebrew…"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" </dev/null
  echo "→ Configuring Homebrew environment…"
  if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  else
    eval "$(/usr/local/bin/brew shellenv)"
  fi
  echo "✔️  Homebrew installed."
else
  echo "✔️  Homebrew already installed."
fi

# 3) Oh My Zsh (unattended, keep your .zshrc, don't chsh or auto-launch)
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "→ Installing Oh My Zsh…"
  RUNZSH=no CHSH=no KEEP_ZSHRC=yes \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  echo "✔️  Oh My Zsh installed."
else
  echo "✔️  Oh My Zsh already present."
fi

# 4) Powerlevel10k theme
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
  echo "→ Installing Powerlevel10k theme…"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
    "$ZSH_CUSTOM/themes/powerlevel10k"
  echo "✔️  Powerlevel10k installed."
else
  echo "✔️  Powerlevel10k already installed."
fi

# 5) Clone dotfiles and extract aliases + completions
DOTFILES_DIR="$HOME/.dotfiles"
if [ -d "$DOTFILES_DIR" ]; then
  backup "$DOTFILES_DIR"
fi
echo "→ Cloning your dotfiles repo…"
git clone https://github.com/glamcoder/dotfiles.git "$DOTFILES_DIR"

COMPDIR="$DOTFILES_DIR/zsh/completions"
mkdir -p "$COMPDIR"

# Git completion
if [ ! -f "$COMPDIR/_git" ]; then
  echo "→ Installing Git zsh completion…"
  curl -fsSL \
    https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh \
    -o "$COMPDIR/_git"
fi

# Kubernetes (kubectl) completion
if [ ! -f "$COMPDIR/_kubectl" ]; then
  echo "→ Installing kubectl zsh completion…"
  curl -fsSL \
    https://raw.githubusercontent.com/kubernetes/kubernetes/master/staging/src/k8s.io/kubectl/pkg/cmd/completion/zsh_completion.sh \
    -o "$COMPDIR/_kubectl"
fi

# Docker completion
if [ ! -f "$COMPDIR/_docker" ]; then
  echo "→ Installing Docker zsh completion…"
  curl -fsSL \
    https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker \
    -o "$COMPDIR/_docker"
fi

# 6) Aliases
if [ -e "$HOME/.alias" ] || [ -L "$HOME/.alias" ]; then
  backup "$HOME/.alias"
fi
echo "→ Symlinking your aliases file…"
ln -s "$DOTFILES_DIR/.alias" "$HOME/.alias"

# Patch ~/.zshrc
ZSHRC="$HOME/.zshrc"
backup "$ZSHRC"

# Source aliases
if ! grep -Fxq "source \$HOME/.alias" "$ZSHRC"; then
  echo "→ Adding alias source to .zshrc…"
  {
    echo ""
    echo "# ═══════════════════════════════════════"
    echo "# Load my custom aliases"
    echo "if [ -f \$HOME/.alias ]; then"
    echo "  source \$HOME/.alias"
    echo "fi"
  } >> "$ZSHRC"
fi

# Load custom completions via fpath & compinit
if ! grep -Fxq "fpath=(\$HOME/.dotfiles/zsh/completions \$fpath)" "$ZSHRC"; then
  echo "→ Configuring custom completions in .zshrc…"
  {
    echo ""
    echo "# ═══════════════════════════════════════"
    echo "# Zsh completions from ~/.dotfiles"
    echo "fpath=(\$HOME/.dotfiles/zsh/completions \$fpath)"
    echo "autoload -Uz compinit && compinit"
  } >> "$ZSHRC"
fi

echo "🎉 All done! Please restart your terminal or run 'source ~/.zshrc' to apply changes."
