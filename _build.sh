#! /bin/sh
blogofile build
mkdir -p _website
rm -rf _website/*
mv -f _site/* _website/
rm -rf _site
