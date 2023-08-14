#!/bin/bash

# make a cronjob something like this: (crontab -e)
# 0 * * * * /home/kyle/.config/nitrogen/reroll.sh

/usr/local/bin/node /home/kyle/.config/nitrogen/downloadRedditWallpaper.js

export DISPLAY=":0"
nitrogen --restore

