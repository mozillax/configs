#!/bin/bash

# strawberry info display script by NHerby

case "$1" in

# Create a copy of the cover
cover)

file=`qdbus org.mpris.MediaPlayer2.strawberry /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata | grep artUrl`
FILENAME=$( echo "$file" | cut -c 22- )

if [ "$FILENAME" != "" ]
then
cp "$FILENAME" ~/scripts/cover.jpg
fi
;;

# Now Playing Info

status) 

status=`qdbus org.mpris.MediaPlayer2.strawberry /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlaybackStatus`
if [ "$status" == "Paused" ]
then status="Playing"
fi

echo $status

;;

artist) qdbus org.mpris.MediaPlayer2.strawberry /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata | grep artist | cut -c 15- ;;

title) qdbus org.mpris.MediaPlayer2.strawberry /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata | grep title | cut -c 14- ;;

album) qdbus org.mpris.MediaPlayer2.strawberry /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata | grep album |  head -1| cut -c 14- ;;

year) qdbus org.mpris.MediaPlayer2.strawberry /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata | grep year | cut -c 12- ;;

genre) qdbus org.mpris.MediaPlayer2.strawberry /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata | grep genre | cut -c 14- ;;

progress)

curr=`qdbus org.mpris.MediaPlayer2.strawberry /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Position`
tot=`qdbus org.mpris.MediaPlayer2.strawberry /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Metadata | grep length`
total=$( echo "$tot" | cut -c 14- )

if [ "$total" != "" ]
then
let progress=curr*100
let progress=progress/total
fi

echo $progress

;;

esac
