#!/bin/sh
if [ $# -ne 1 ]
then
  echo "usage: ./_new.sh 'the title'"
  exit 1;
fi

mkdir -p _posts
echo "---\ntitle: $1 \ndate: `date '+%G/%m/%d %H:%M:%S'`\ncategories:\n---" \
  >> _posts/`date +%G-%m-%d`-${1// /-}.markdown
