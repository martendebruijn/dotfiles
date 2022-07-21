Make_links () {
  if [ $# -ge 1 ]
  then
    DIR="$1/"
  else
    DIR=""
  fi

  for file in .*;
  do
    if [[ $file == "." || $file == ".." || $file == ".DS_Store" || $file == ".git" || $file == ".zshenv.example" ]]; then
      continue
    fi
    echo 🔗Linking $file...
    PATH="$HOME/dotfiles/$DIR$file"
    ln -s $PATH ~/$file
    echo "✅Link made for $file\r\n" 
  done
}

Make_links
cd ./zsh
Make_links 'zsh'
cd ../git
Make_links 'git'
cd ../
echo 🤐Creating .zshenv...
cp ./zsh/.zshenv.example ~/.zshenv
echo "✅Made .zshenv\nPlease enter all the environment variables"