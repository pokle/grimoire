#!/usr/bin/env bash

set -e

if [ ! -d "clojure-cheatsheets" ]; then
  git clone https://github.com/jafingerhut/clojure-cheatsheets
fi

pushd .
cd clojure-cheatsheets/
git reset --hard && git clean -fd && git pull origin master

cd src/clj-jvm
lein run links-to-grimoire
popd

cp clojure-cheatsheets/src/clj-jvm/cheatsheet-full.html .
sed  -i -e 1,3d cheatsheet-full.html
perl -i -p -e 's%http://grimoire.arrdem.com%{{ site.baseurl }}%g' cheatsheet-full.html
perl -i -p -e 's%/1.6.0%{{ site.clojure_version }}%g' cheatsheet-full.html
perl -i -p -e 's%cheatsheet_files%{{ site.baseurl }}public%g' cheatsheet-full.html
mv -f cheatsheet-full.html _includes/cheatsheet.html
