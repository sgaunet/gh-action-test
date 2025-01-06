#!/usr/bin/env bash

# git configuration
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR_ID}+${GITHUB_ACTOR}@users.noreply.github.com"

# Clone the repository
git clone "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
cd "$(basename ${GITHUB_REPOSITORY})" || exit 1

# Generate the badge
if (( BADGE_VALUE < LIMIT_COVERAGE )); then
  export color=${BADGE_COLOR_UNDER_LIMIT}
else
  export color=${BADGE_COLOR_OVER_LIMIT}
fi

set -x 

gobadger -c "${color}" -t "${BADGE_LABEL}" -v "${BADGE_VALUE}" -o "${BADGE_FILENAME}"
git add "${BADGE_FILENAME}"

# # Test if there is a change
# if git diff --quiet; then
#   echo "No change"
#   exit 0
# fi

# Commit and push
git commit -m "[action gobadger] Update ${BADGE_FILENAME}"
git remote set-url origin https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git
git push

echo "https://raw.githubusercontent.com/wiki/${GITHUB_REPOSITORY}/${BADGE_FILENAME}"
