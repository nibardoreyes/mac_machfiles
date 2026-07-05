# ============================================
# Homebrew (must be early so brew works everywhere)
# ============================================
eval "$(/opt/homebrew/bin/brew shellenv)"

# ============================================
# PATH additions (must come early too)
# ============================================
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# ============================================
# Zsh options
# ============================================
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS

# ============================================
# History (better defaults)
# ============================================
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS

# ============================================
# Completion system (MUST be early for zstyle)
# ============================================
autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list \
  'm:{a-zA-Z}={A-Za-z}' \
  'r:|[._-]=* r:|=*' \
  'l:|=* r:|=*'

zstyle ':completion:*' menu select

# ============================================
# Plugins (Homebrew)
# ============================================
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# ============================================
# Starship prompt
# ============================================
eval "$(starship init zsh)"

# ============================================
# zoxide (smart cd)
# ============================================
eval "$(zoxide init zsh)"

# ============================================
# fzf (macOS Homebrew safe paths)
# ============================================
if [ -f "$(brew --prefix)/opt/fzf/shell/completion.zsh" ]; then
  source "$(brew --prefix)/opt/fzf/shell/completion.zsh"
  source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"
fi

# ============================================
# Aliases
# ============================================
alias ls='eza --icons'
alias ll='eza -l --icons'
alias la='eza -la --icons'
alias lt='eza --tree --icons'

alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'

alias ff='fastfetch'
alias e='yazi'

# ============================================
# Key Bindings
# ============================================
bindkey -s '^f' 'source ~/.config/scripts/fuzzy_dir.sh\n'