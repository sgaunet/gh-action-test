#!/usr/bin/env bash

tmpdir="/tmp"
destination="README.md"
content="README.md content"

echo "$content" > "$tmpdir/$destination"

# git config --global user.email "you@example.com"
# git config --global user.name "Your Name"
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR_ID}+${GITHUB_ACTOR}@users.noreply.github.com"

git clone "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
cd "$(basename ${GITHUB_REPOSITORY})" || exit 1
echo "voila dfkhjdfkgh" > README.md

wget https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Firefox_logo%2C_2019.svg/1200px-Firefox_logo%2C_2019.svg.png -O firefox.png
wget https://www.svgrepo.com/show/94640/firefox.svg -O firefox.svg

git add README.md firefox.png firefox.svg
git commit -m "Update README.md"
git remote set-url origin https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
git push
