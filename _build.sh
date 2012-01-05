#! /bin/sh
mkdir -p _tmp
mv -f _site/.[^.]* _tmp >> /dev/null 2>&1

blogofile build

mv -f _tmp/.[^.]* _site >> /dev/null 2>&1
rm -rf _tmp

