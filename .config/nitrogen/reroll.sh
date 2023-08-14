#!/bin/bash

# make a cronjob something like this: (crontab -e)
# 0 * * * * /home/kyle/.config/nitrogen/reroll.sh

/home/kyle/.config/nitrogen/downloadRedditWallpaper.py

export DISPLAY=":0"
nitrogen --restore
