# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/Documents/personal/personal-coding-projects/zsh-autocomplete/zsh-autocomplete.plugin.zsh  
bindkey '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
zstyle ':autocomplete:*complete*:*' insert-unambiguous yes

function addToPATH {
  case ":$PATH:" in
    *":$1:"*) :;; # already there
    *) PATH="$1:$PATH";; # or PATH="$PATH:$1"
  esac
}
# Add own scripts
addToPATH $HOME/Documents/personal/personal-coding-projects/dotfiles/bin
addToPATH $HOME/sqlcl/bin
addToPATH $HOME/.rbenv/bin

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Date format
HIST_STAMPS="dd.mm.yyyy"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Oh my zsh plugins
plugins=(
	git
)

# Source files
source $ZSH/oh-my-zsh.sh
source $HOME/.zshalias
source $HOME/.zshfunctions

source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# Add thefuck
eval $(thefuck --alias)