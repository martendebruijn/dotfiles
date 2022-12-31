#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Install/update Node LTS
# @raycast.mode fullOutput
# @raycast.packageName Marten Scripts
# @raycast.icon 🟢
# @raycast.description Install or update the LTS version of Node.js with homebrew
# @raycast.author Marten de Bruijn
# @raycast.authorURL https://www.github.com/martendebruijn

LAST_VERSION_NAME=$(brew search /node@\[0-9\]\[0-9\]/ | tail -1)
LAST_VERSION=$(brew search /node@\[0-9\]\[0-9\]/ | tail -1 | sed 's/node@//')

function add-node {
  readonly TO_INSTALL=${1:?TO_INSTALL must be specified.}
  brew list | grep 'node' | while read -r VERSION ; do
    echo "🍺uninstalling $VERSION"
    brew uninstall -q --ignore-dependencies "$VERSION"
    sed -i '' "s#export PATH='/opt/homebrew/$VERSION/bin:$PATH'##" ~/dotfiles/zsh/.zshrc # does this even work? because $PATH becomes resolved
  done
  echo "🍺installing ${TO_INSTALL}"
  brew install -q node@"${TO_INSTALL}"
  START="export PATH="
  MID="/opt/homebrew/opt/node@$LTS_VERSION/bin:"
  # shellcheck disable=SC2016
  END='$PATH'
  echo "${START}${MID}${END}" >> ~/.zshrc
}

if (("$LAST_VERSION" % 2)); then
  echo '🟢last node version is not a lts version'
  LTS_VERSION=$(brew search /node@\[0-9\]\[0-9\]/ | tail -2 | head -1 | sed 's/node@//')
  LTS_INFO=$(brew info --json node@"$LTS_VERSION")
  if [ "$(echo "$LTS_INFO" | jq -r '.[].installed[0].version')" == null ]; then
    echo '🟢last lts version is not installed'
    add-node "$LTS_VERSION"
  else
    echo '🟢last lts version already installed'
    # check if "node" is installed
      LTS_INFO=$(brew info --json "$LAST_VERSION_NAME")
    if [ "$(echo "$LTS_INFO" | jq -r '.[].installed[0].version')" == null ]; then
      echo '🟢last version not installed'
    else 
      echo '🟢last version installed'
      echo "🍺uninstalling last node version ($LAST_VERSION_NAME)"
      brew uninstall -q --ignore-dependencies node
      echo 'i maybe have to link/unlink node'
      # brew link node@"$LTS_VERSION"
    fi  
  fi
else
  echo '🟢last node version is a lts version'
  LTS_INFO=$(brew info --json "$LAST_VERSION_NAME")
  if [ "$(echo "$LTS_INFO" | jq -r '.[].installed[0].version')" == null ]; then
    echo "🟢last lts version ($LAST_VERSION_NAME) is not installed"
    add-node "$LAST_VERSION"
  else
    echo '🟢last lts version already installed'
  fi
fi

# you will get this warning when you have a specific node version (ohter than just node) installed
# Warning: Some installed formulae are missing dependencies.
# You should `brew install` the missing dependencies:
#   brew install node
