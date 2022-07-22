# Update homebrew
# ./update-brew.sh
brew update; brew upgrade; brew autoremove; brew cleanup; brew doctor;
cd ~/dotfiles/brew/
brew bundle dump --force
git status -s Brewfile
if git status -s Brewfile | grep -q 'M Brewfile'; then
  git commit -m "🧹 chore(Brewfile): update brewfile"
  git push
fi
