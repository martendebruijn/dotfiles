#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Install/update Node LTS
# @raycast.mode fullOutput
# @raycast.packageName Marten Scripts
# @raycast.icon 🟢
# @raycast.description Install or update the LTS version of Node.js with homebrew
# @raycast.author Marten de Bruijn
# @raycast.authorURL https://www.github.com/martendebruijn


# echo "export PATH='/opt/homebrew/opt/$LAST_VERSION_NAME/bin:$PATH'" >> ~/.zshrc
# becomes -> export PATH="/opt/homebrew/opt/node@$LTS_VERSION/bin:$PATH"
# we want -> export PATH="/opt/homebrew/opt/node@18/bin:$PATH"

LAST_VERSION_NAME=$(brew search /node@\[0-9\]\[0-9\]/ | tail -1)
# LAST_VERSION=$("$LAST_VERSION_NAME" | sed 's/node@//') # -> command not found
LAST_VERSION=$(brew search /node@\[0-9\]\[0-9\]/ | tail -1 | sed 's/node@//')

# Both the if and else are almost identical -> so make it DRY
if (("$LAST_VERSION" % 2)); then
  echo '🟢last node version is not a lts version'
  LTS_VERSION=$(brew search /node@\[0-9\]\[0-9\]/ | tail -2 | head -1 | sed 's/node@//')
  LTS_INFO=$(brew info --json node@"$LTS_VERSION")
  if [ "$(echo "$LTS_INFO" | jq -r '.[].installed[0].version')" == null ]; then
    echo '🟢last lts version is not installed'
    brew list | grep 'node' | while read -r line ; do
    # hier kan node instaan toch?
       echo "🍺uninstalling version $line"
       brew uninstall -q --ignore-dependencies "$line"
       # remove path from .zshrc
       sed -i '' "s#export PATH='/opt/homebrew/$line/bin:$PATH'##" ~/dotfiles/zsh/.zshrc
    done
    echo "🍺installing latest node lts version (node@$LTS_VERSION)"
    brew install -q node@"$LTS_VERSION"
    # add lts version to path
    # shellcheck disable=SC2016
    echo 'export PATH="/opt/homebrew/opt/node@$LTS_VERSION/bin:$PATH"' >> ~/.zshrc
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
    brew list | grep 'node' | while read -r line ; do
       echo "🍺uninstalling version $line"
       brew uninstall -q --ignore-dependencies "$line"
       # remove path from .zshrc
       sed -i '' "s#export PATH='/opt/homebrew/$line/bin:$PATH'##" ~/dotfiles/zsh/.zshrc
    done
    echo '🍺installing latest node lts version'
    brew install -q "$LAST_VERSION_NAME"
    # add lts version to path
      # shellcheck disable=SC2016
    echo 'export PATH="/opt/homebrew/opt/$LAST_VERSION_NAME/bin:$PATH"' >> ~/.zshrc
  else
    echo '🟢last lts version already installed'
  fi
fi

# you will get this warning when you have a specific node version (ohter than just node) installed
# Warning: Some installed formulae are missing dependencies.
# You should `brew install` the missing dependencies:
#   brew install node