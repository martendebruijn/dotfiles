#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Update homebrew
# @raycast.mode fullOutput
# @raycast.packageName Marten Scripts
# @raycast.icon 🍺
# @raycast.description Update homebrew and automatically push to GitHub and GitLab
# @raycast.author Marten de Bruijn
# @raycast.authorURL https://www.github.com/martendebruijn

brew update -q; brew upgrade --cask --greedy; brew autoremove; brew cleanup; brew doctor;
cd ~/dotfiles/brew/ || exit
brew bundle dump --force --describe
if git status -s Brewfile | grep -q 'M Brewfile'; then
  git add Brewfile
  git commit -m "🧹 chore(Brewfile): update brewfile"
  git push
fi
