#!/bin/bash

brew update -q; brew upgrade; brew autoremove; brew cleanup; brew doctor;
cd ~/dotfiles/brew/ || exit
brew bundle dump --force --describe
if git status -s Brewfile | grep -q 'M Brewfile'; then
  git add Brewfile
  git commit -m "🧹 chore(Brewfile): update brewfile"
  git push
fi
