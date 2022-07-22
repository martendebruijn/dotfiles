# Update homebrew
# ./update-brew.sh
brew update -q; brew upgrade; brew autoremove; brew cleanup; brew doctor;
cd ~/dotfiles/brew/
brew bundle dump --force
if git status -s Brewfile | grep -q 'M Brewfile'; then
  git add Brewfile
  git commit -m "🧹 chore(Brewfile): update brewfile"
  git push
fi
