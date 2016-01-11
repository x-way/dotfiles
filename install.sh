#!/bin/sh

TARGET="$HOME"

SOURCE=`dirname $0`
SOURCE=`cd $SOURCE ; pwd`

for f in `cd $SOURCE ; ls -a|egrep -v '^(\.|\.\.|\.git|install\.sh)$'` ; do
	echo "ln -s $SOURCE/$f $TARGET/$f"
done
