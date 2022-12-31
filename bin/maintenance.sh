#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Maintenance script
# @raycast.mode fullOutput
# @raycast.packageName Marten Scripts
# @raycast.icon ⚙️
# @raycast.description Maintenance Mac
# @raycast.author Marten de Bruijn
# @raycast.authorURL https://www.github.com/martendebruijn

while getopts p:rh flag
do
  case "${flag}" in
    p) brew_path=${OPTARG};;
    r) use_repo=true;;
    h) print_help;;
    *) echo "Invalid flag" >&2
    print_help;;
  esac
done

print_help() {
  printf "path [-p] path to save Brewfile\nrepo [-r] push Brewfile to a remote repository. The Brewfile has to be inside a git repository with a remote set and path [-p] is required\nhelp [-h] shows this page" >&2
  exit 1
}

# Add contents from install-node-lts when finished

# Update Homebrew
echo '🍺Updating Homebrew...'
brew update -q
echo '⬆️ Upgrade casks and formulae...'
brew upgrade --cask --greedy -q
echo '⬆️ Upgrade apps from Apple store'
mas upgrade
echo '🗑️ Uninstall formulae that are no longer needed'
brew autoremove &> '/dev/null'
echo '🧹Clean up fromulae and casks'
brew cleanup -q
echo '🍺Check for potential problems'
brew doctor

if [ -p "$brew_path" ];then
  echo "🍺Creating Brewfile at $brew_path"
  brew bundle dump -f --describe --file="$brew_path/Brewfile"

  if [[ ${use_repo} == true ]];then
    cd "$brew_path" || exit
    if git status -s Brewfile | grep -q 'M Brewfile';then
      echo '👾Push Brewfile to remote repository'
      git add Brewfile
      git commit -m "🧹 chore(Brewfile): update brewfile"
      git push -q
    else
      echo '✅Brewfile already up to date'
    fi
  fi
fi

echo '📦Update global npm packages'
npm upgrade -g --silent

echo '🗃️ Update tldr database'
tldr --update &> '/dev/null'

# Doesn't install...
# echo '🍎Install Mac updates, may ask for your password'
# softwareupdate -i -a