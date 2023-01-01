#!/bin/bash

prepend_zero () {
        seq -f "%02g" $1 $1
}

artist=$(echo -n $(cmus-remote -C 'format_print %F' | sed 's/.mp3//'))

if [[ $artist = *[!\ ]* ]]; then
        position=$(cmus-remote -C status | grep position | cut -c 10-)
        minutes1=$(prepend_zero $(($position / 60)))
        seconds1=$(prepend_zero $(($position % 60)))
        echo -n "$minutes1":"$seconds1 $artist"
else
        echo
fi
