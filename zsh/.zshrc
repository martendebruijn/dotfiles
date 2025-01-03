# Load [Zsh Autocomplete plugin](https://github.com/marlonrichert/zsh-autocomplete)
# Keep near the top, before any calls to compdef:
source ~/Documents/personal/personal-coding-projects/zsh-autocomplete/zsh-autocomplete.plugin.zsh  

# Use the Tab key for menu completion and Shift+Tab to navigate to a list of autocompletions in reverse order
bindkey '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

# First insert the common substring in all widgets
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes

# Add something to $PATH, only when it's not already there
# This prevents adding duplicates to $PATH whenever source .zshrc is called
function addToPATH {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}

# Add own scripts
addToPATH $HOME/sqlcl/bin
addToPATH $HOME/.rbenv/bin

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"
# Path to Oh My Zsh Custom directory
export ZSH_CUSTOM="$HOME/Documents/personal/personal-coding-projects/dotfiles/zsh/custom"

# Pitcher environment
export PITCHER_ENVIRONMENT=development

# Date format
HIST_STAMPS="dd.mm.yyyy"

# Do not enable a oh-my-zsh theme, because we use Starship
ZSH_THEME=""

# Oh my zsh plugins
plugins=(
	git
)

# Add Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Add thefuck
eval $(thefuck --alias)

# Add rbenv
eval "$(~/.rbenv/bin/rbenv init - zsh)"

# Use Starship
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/Users/marten/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
