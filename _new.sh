#!/bin/sh
if [ $# -ne 1 ]
then
  echo "No post title! usage: _new.sh 'the title'"
  exit 1;
fi

mkdir -p _posts
filepath=_posts/`date +%G-%m-%d`-${1// /-}.markdown
echo "---\ntitle: $1 \ndate: `date '+%G/%m/%d %H:%M:%S'`\ncategories:\n---" \
  >> $filepath
echo "new post: $filepath"
