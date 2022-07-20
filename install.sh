for file in .*;
do
 if [[ $file == "." || $file == ".." || $file == ".DS_Store" || $file == ".git" ]]; then
    continue
  fi
  echo 🔗Linking $file...
  ln -s $HOME/dotfiles/$file ~/$file
  echo "✅Link made for $file\r\n"
done

cd ./zsh
for file in .*;
do
 if [[ $file == "." || $file == ".." || $file == ".DS_Store" || $file == ".zshenv.example" ]]; then
    continue
  fi
  echo 🔗Linking $file...
  ln -s $HOME/dotfiles/zsh/$file ~/$file
  echo "✅Link made for $file\r\n"
done

cd ../git
for file in .*;
do
 if [[ $file == "." || $file == ".." || $file == ".DS_Store" ]]; then
    continue
  fi
  echo 🔗Linking $file...
  ln -s $HOME/dotfiles/git/$file ~/$file
  echo "✅Link made for $file\r\n"
done

cd ../
echo 🤐Creating .zshenv...
cp ./zsh/.zshenv.example ~/.zshenv
echo "✅Made .zshenv\nPlease enter all the environment variables"