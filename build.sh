#!/bin/sh

# This file bundles the client-side JavaScript using browserify.
# It's called "bun" because that's faster to type than "bundle".

# WARNING: Depending on the implementation of 'find' in your
# distribution, this script may fail.
# If you develop of less platform-dependant solution please
# submit a pull request.

# Make ./processed if it doesn't exist
mkdir -p ./processed
echo "// build.sh needs at least one file" > ./source/garbage_js.js
echo "// build.sh needs at least one file" > ./source/garbage_json.json

# Compile CoffeeScript source
echo "[1] Processing CoffeeScript files"
coffee --compile --output processed/ source/
# Move over any JavaScript source
echo "[2] Copying pure source"
cd source
cp --parents `find -name \*.js` ../processed/
cp --parents `find -name \*.json` ../processed/
cd ..
echo "[Done]"
