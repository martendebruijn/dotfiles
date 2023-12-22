# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

function addToPATH {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}

# Add own scripts
addToPATH $HOME/dotfiles/bin
addToPATH $HOME/sqlcl/bin

export ZSH=$HOME/.oh-my-zsh

# Date format
HIST_STAMPS="dd.mm.yyyy"

# Oh my zsh plugins
plugins=(
	git
)

# Source files
source $ZSH/oh-my-zsh.sh
source $HOME/dotfiles/zsh/.zshalias
source $HOME/dotfiles/zsh/.zshfunctions
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Add thefuck
eval $(thefuck --alias)
