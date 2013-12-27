#!/bin/bash
# xinit script
# part of
# bhs-sign Version 1 27.12.2013 oli@mad-fx.de
# This xinit script, together with bhs-prepare downloads and runs a slideshow of pictures and videos
# Tested with Raspian on Raspberry Pi
# Requirements: FEH picture viewer, OMXPLAYER video player, working accelerated X
# Have fun! :)
#
# todo:
# *read all infos from a config file
# *detect file types via acutal file, not extension
# *download also checks for a new script version on server
# *DEBUG variable switches on log output
# Clean it all up!
# *make it all happen under one roof (one player!) with the abilities for tickers(rss) and a clock

#Directorys and settings
	DIR=/home/pi/slideshow
	LISTS=/home/pi/lists
		
	#JPG Viewer settings
	VIEWER=/usr/bin/feh
	VOPTIONS="--quiet --full-screen -f"
	VONCE="--cycle-once"
	VDELAY="--slideshow-delay"
	DELAY="10"
	
	#Video Viewer settings
	PLAYER=/usr/bin/omxplayer
	POPTIONS=""

# switch off screensaver
xset s off
xset -dpms

# for future use: we can start a window manager in background;
# matchbox-window-manager &

# for future ruse: refresh the scripts / update
# wget ....

#get the new data and prepare the lists
/home/pi/bhs-prepare

NUMBERS=$(ls -1 $LISTS|wc -l) #Number of lists in $LISTS after the update

# run forever from here on out
while true; 
	do
		logger BHS "DEBUG: Endless loop started."
		cd $DIR
		for file in $(ls -1 $LISTS) #give me the lists!
			do
		        logger BHS "Number of lists: $NUMBERS"
			if [ "$NUMBERS" -gt "1" ]; #only one list? = no --cycle-once option so feh does not quit
					then 
					OPTIONS="$VONCE $VDELAY $DELAY $VOPTIONS"
					logger BHS "DEBUG: Several lists, breaking cycle!"
					else 
					OPTIONS="$VDELAY $DELAY $VOPTIONS"
					logger BHS "DEBUG: Single list, not breaking cycle!"
			fi
	logger BHS "Kommandozeile $OPTIONS"
				
			type=`echo "$file" | cut -d'-' -f2` # get the file type video or image
        		if [ "$type" = "image" ];
               		                 then $VIEWER $OPTIONS $LISTS/$file #show the image

        		fi
        		if [ "$type" = "video" ]; 
    		                            then $PLAYER $POPTIONS $(cat $LISTS/$file) #play the video
						xrefresh -display :0 #refresh the display, since the player writes to the framebuffer
        		fi
		done
		logger BHS "DEBUG: Loop finished."
done
