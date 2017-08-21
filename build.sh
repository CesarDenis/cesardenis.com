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
rm -rf ../cesardenis.com.gh-pages

# clone 'gh-pages' branch of the repository using encrypted GH_TOKEN for authentification
git clone -b gh-pages https://${GH_TOKEN}@github.com/CesarDenis/cesardenis.github.io.git ../cesardenis.com.gh-pages

# copy generated HTML site to 'gh-pages' branch
cp -R dist/* ../cesardenis.com.gh-pages

# commit and push generated content to 'gh-pages' branch
# since repository was cloned in write mode with token auth - we can push there
cd ../cesardenis.com.gh-pages
git config user.email "cesar@cesardenis.com"
git config user.name "cesardenis"
git add -A .
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --quiet origin gh-pages > /dev/null 2>&1
