# eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(/usr/local/bin/brew shellenv)"

# Setting PATH for Python 3.10
# The original version is saved in .zprofile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.10/bin:${PATH}"
export PATH
