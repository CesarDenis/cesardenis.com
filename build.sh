#!/bin/bash
#
## only process script when started not by pull request (PR)
if [ "$TRAVIS_PULL_REQUEST" != "false" ]; then
  echo "This is PR, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

# build site with jekyll
bower install
gulp build --prod


# cleanup
echo "Cleanup"
rm -rf ../cesardenis.com.gh-pages
echo "Cleanup Done"

# clone 'gh-pages' branch of the repository using encrypted GH_TOKEN for authentification
echo "Clone"
git clone -b gh-pages https://${GH_TOKEN}@github.com/CesarDenis/cesardenis.com.git ../cesardenis.com.gh-pages
echo "Clone Done"

# copy generated HTML site to 'gh-pages' branch
echo "Copy HTML"
cp -R dist/* ../cesardenis.com.gh-pages
echo "Copy HTML Done"

# commit and push generated content to 'gh-pages' branch
# since repository was cloned in write mode with token auth - we can push there
echo "Commit and Push"
cd ../cesardenis.com.gh-pages
git config user.email "cesar@cesardenis.com"
git config user.name "cesardenis"
git add -A .
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --quiet origin gh-pages > /dev/null 2>&1
echo "Commit and Push Done"