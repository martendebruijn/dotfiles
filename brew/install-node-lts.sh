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
# LAST_VERSION=$("$LAST_VERSION_NAME" | sed 's/node@//') # -> command not found
LAST_VERSION=$(brew search /node@\[0-9\]\[0-9\]/ | tail -1 | sed 's/node@//')

# Both the if and else are almost identical -> so make it DRY
if (("$LAST_VERSION" % 2)); then
  echo 'last node version is not a lts version'
  LTS_VERSION=$(brew search /node@\[0-9\]\[0-9\]/ | tail -2 | head -1 | sed 's/node@//')
  LTS_INFO=$(brew info --json node@"$LTS_VERSION")
  if [ "$(echo "$LTS_INFO" | jq -r '.[].installed[0].version')" == null ]; then
    echo 'last lts version is not installed'
    # check which version(s) of node is installed (if any) -> uninstall them -> and remove their paths from .zshrc
        # check which version(s) of node is installed (if any) -> uninstall them -> and remove their paths from .zshrc
    brew list | grep 'node' | while read -r line ; do
      if [ "$line" == "$LAST_VERSION_NAME" ]; then
       echo "$line is latetst version"
      else 
       echo "uninstalling version $line"
       # brew uninstall "$line"
       # remove path from .zshrc
      fi
    done
    echo "installing latest node lts version (node@$LTS_VERSION)"
    # brew install node@"$LTS_VERSION"
    # add lts version to path
  else
    echo 'last lts version is installed'
  fi
else
  echo 'last node version is a lts version'
  LTS_INFO=$(brew info --json "$LAST_VERSION_NAME")
  if [ "$(echo "$LTS_INFO" | jq -r '.[].installed[0].version')" == null ]; then
    echo "last lts version ($LAST_VERSION_NAME) is not installed"
    # check which version(s) of node is installed (if any) -> uninstall them -> and remove their paths from .zshrc
    brew list | grep 'node' | while read -r line ; do
      if [ "$line" == "$LAST_VERSION_NAME" ]; then
       echo "$line is latetst version"
      else 
       echo "uninstalling version $line"
       # brew uninstall "$line"
       # remove path from .zshrc
      fi
    done
    echo 'installing latest node lts version'
    # brew install node@"$LTS_VERSION"
    # add lts version to path
  else
    echo 'last lts version is installed'
  fi
fi

# you will get this warning when you have a specific node version (ohter than just node) installed
# Warning: Some installed formulae are missing dependencies.
# You should `brew install` the missing dependencies:
#   brew install node