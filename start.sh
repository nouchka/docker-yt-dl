#!/bin/bash

PASSWORD_FILE=/tmp/.rsync
echo $RSYNC_PASSWORD > $PASSWORD_FILE
chmod 400 $PASSWORD_FILE

##/usr/local/bin/youtube-dl --get-filename -o "%(title)s.%(ext)s" -f 18 $1 --restrict-filenames
/usr/local/bin/youtube-dl -f 18 $YOUTUBE_ID

rsync -rzv --password-file=$PASSWORD_FILE *.mp4 $RSYNC_USER@$RSYNC_SERVER::$RSYNC_REPO/

##Backup id to DL again
rsync -rzv --password-file=$PASSWORD_FILE $RSYNC_USER@$RSYNC_SERVER::$RSYNC_REPO/backup.txt .
echo $YOUTUBE_ID >> backup.txt
rsync -rzv --password-file=$PASSWORD_FILE backup.txt $RSYNC_USER@$RSYNC_SERVER::$RSYNC_REPO/
