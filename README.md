bhs-sign
========

Digital signage scripts for Rasperry PI or any other linux system with X

This is some scripts I cobbled together for our local theatre.
Two monitors in the foyer show JPG slides and videos of upcoming events, infos about the night and so on

This is a simple and open source you can get, there is no third party involved, all you need is a ftp server to put your slideshow data, and even that is optional, the files can easily come froma local source as well.
The number of screens is only limited by the names of subdirs you can think of

Features:
-Downloads images and videos from a FTP server
-Processes them into slideshow lists (I know, its dirty!)
-Runs an endless slideshow

Requirements: 
-FEH picture viewer
-OMXPLAYER video player
-wget
-working accelerated X

TODO:
*read all infos from a config file
*detect file types via acutal file, not extension
*download also checks for a new script version on server
*DEBUG variable switches on log output
*Clean it all up!
*make it all happen under one roof (one player!) with the abilities for news tickers(rss) and a clock


