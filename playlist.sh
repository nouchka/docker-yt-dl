#!/bin/bash

download_video () {
	echo Download $1
	sleep 1
	##/usr/local/bin/youtube-dl --get-filename -o "%(upload_date)s - %(uploader_id)s - %(id)s - %(title)s.%(ext)s" -f 18 --restrict-filenames $1
	/usr/local/bin/youtube-dl -w -o "%(upload_date)s - %(uploader_id)s - %(id)s - %(title)s.%(ext)s" -f 18 --restrict-filenames $1
}

dowload_playlist () {
	wget https://www.youtube.com/feeds/videos.xml?channel_id=$1 -qO -|grep "rel=\"alternate\" href=\"https://www.youtube.com/watch?v="| awk -F '=' '{print $4}'|sed "s/\"\/>//g"| while read YT_ID
	do
		download_video $YT_ID
	done
}

cd $YOUTUBE_DIRECTORY
playlists=( $YOUTUBE_PLAYLIST )
for playlist in "${playlists[@]}"
do
	echo $playlist
	dowload_playlist $playlist
	sleep 5
done
