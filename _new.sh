#!/bin/sh
if [ $# -eq 0 ]
then
  echo "No post title! Usage: _new.sh 'the title'"
  exit 1;
fi

mkdir -p _posts
filepath=_posts/`date +%G-%m-%d`-`echo $1|tr ' ' '-'`.markdown

echo "\
---
title: $1 
date: `date '+%G/%m/%d %H:%M:%S'`
categories:
---" >> $filepath

echo "new post: $filepath"
