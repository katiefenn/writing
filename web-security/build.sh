#!/bin/bash

set -e

npm install --no-save npm@6.4.1

NPM_DOCS_SRC="node_modules/npm/doc"
NPM_DOCS_DEST="docs_collections/_cli-documentation"

if [ -d ${NPM_DOCS_DEST} ]
  then
    rm -r ${NPM_DOCS_DEST}
fi
mkdir ${NPM_DOCS_DEST}

cp -pr ${NPM_DOCS_SRC}/cli ${NPM_DOCS_DEST}/cli
cp -pr ${NPM_DOCS_SRC}/files ${NPM_DOCS_DEST}/files
cp -pr ${NPM_DOCS_SRC}/misc ${NPM_DOCS_DEST}/misc
rm -f  docs_cli/misc/npm-index.md
## rename for alphebetization
mv ${NPM_DOCS_DEST}/cli/npm.md ${NPM_DOCS_DEST}/cli/npm-npm.md
mv ${NPM_DOCS_DEST}/files/npmrc.md ${NPM_DOCS_DEST}/files/npm-npmrc.md
mv ${NPM_DOCS_DEST}/files/package-lock.json.md ${NPM_DOCS_DEST}/files/npm-package-lock.json.md
mv ${NPM_DOCS_DEST}/files/package.json.md ${NPM_DOCS_DEST}/files/npm-package.json.md

npm run build-cli

env=${ENVIRONMENT:-"staging"}
bundle exec jekyll build --config _config.yml,_config-${env}.yml
