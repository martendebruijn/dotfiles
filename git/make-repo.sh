mkdir $1
cd $1
git init
echo "# $1" >> README.md
touch .gitignore
# Make LICENSE
git add README.md
git add .gitignore
# git add LICENSE
git commit -m "🎉 initial commit"
# !! TODO: Prompt if I made a repo on github and gitlab
git remote add origin git@github.com:martendebruijn/$1
git remote set-url --add --push origin git@github.com:martendebruijn/$1
git remote set-url --add --push origin git@gitlab.com:martendebruijn/$1
git push -u origin main
