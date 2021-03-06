# Generate new repository
# ./make-repo.sh <name> <readme_template> <?license>
# Dependencies: [license](https://www.npmjs.com/package/license)
mkdir $1
cd $1
git init
cp $2 README.md
sed -i '' "s/PROJECT_NAME/$1/g" README.md
touch .gitignore
license $3
git add README.md .gitignore LICENSE
git commit -m "🎉 initial commit"
# !! TODO: Prompt if I made a repo on github and gitlab
git remote add origin git@github.com:$USER/$1
git remote set-url --add --push origin git@github.com:$USER/$1
git remote set-url --add --push origin git@gitlab.com:$USER/$1
git push -u origin main
