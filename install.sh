# Install dotfiles
# ./install.sh
Make_links () {
  if [ $# -ge 1 ]
  then
    dir="$1/"
  else
    dir=""
  fi

  for file in .*;
  do
    if [[ $file == "." || $file == ".." || $file == ".DS_Store" || $file == ".git" || $file == ".zshenv.example" ]]; then
      continue
    fi
    echo 🔗Linking $file...
    path="$(pwd)/$dir$file"
    ln -s $path ~/$file
    echo "✅Link made for $file\r\n" 
  done
}

Make_links
cd ./zsh
Make_links 'zsh'
cd ../git
Make_links 'git'
cd ../vue 'vue'
Make_links 'vue'
cd ../
echo 🤐Creating .zshenv...
cp ./zsh/.zshenv.example ~/.zshenv
echo "✅Made .zshenv\nPlease enter all the environment variables"

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# !! TODO: is this going to work when you don't have a HOMEBREW_GITHUB_ACCESS_TOKEN ?

# Run Brewfile
brew bundle install --file=./Brewfile