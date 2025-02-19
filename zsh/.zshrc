# Load [Zsh Autocomplete plugin](https://github.com/marlonrichert/zsh-autocomplete)
# Add at or near the top of your .zshrc file (before any calls to compdef):
source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

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

# Path to Oh My Zsh installation
export ZSH="$HOME/.oh-my-zsh"

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

# Use Starship
eval "$(starship init zsh)"

