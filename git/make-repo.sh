mkdir $1
cd $1
git init
# !! TODO: Generate template README
echo "# $1" >> README.md
touch .gitignore
# !! TODO: Choose LICENSE
git add README.md .gitignore
# git add LICENSE
git commit -m "🎉 initial commit"
# !! TODO: Prompt if I made a repo on github and gitlab
git remote add origin git@github.com:$USER/$1
git remote set-url --add --push origin git@github.com:$USER/$1
git remote set-url --add --push origin git@gitlab.com:$USER/$1
git push -u origin main
