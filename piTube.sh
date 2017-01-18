#!/bin/sh

#This script checks online for available videos in a given youtube playlist, downloads them locally and plays them locally.
#Any changes in the youtube playlist will be synced to the local files.

#Author:
#Jonathan Dziedzitz
#Karlsruher Institute for Technology
#Institute for Material Handling and Logistcs
#Robotics and Assistance Systems
#jonathan.dziedzitz@kit.edu

###
#USAGE:
#set fullscreen?
fullscreen=true #true, false
#define playlist URL:
youtube_url='https://www.youtube.com/playlist?list=PLUTsdmuMW_mISwkLY6O8qGiPHjycpNrNl'
#run script from terminal
#./piTube.sh
###############################

#check for videosfiles in playlist and download locally
CheckAndDL () {
  #change to piTube_local_files folder
  if [ -d "$HOME/piTube_local_files" ]; then
    echo "piTube_local_files directory exists"
    cd ~/piTube_local_files
  else
    echo "piTube_local_files creating directory"
    mkdir $HOME/piTube_local_files && cd ~/piTube_local_files
  fi

  #check if videos folder exists
  if [ -d "$HOME/piTube_local_files/videos" ]; then
    echo "videos directory exists"
  else
    echo "videos creating directory"
    mkdir $HOME/piTube_local_files/videos
  fi

  # download new files
  cd $HOME/piTube_local_files/videos/
  youtube-dl -f 22 $youtube_url
  cd $HOME/piTube_local_files/

  # get all local filenames
  find $HOME/piTube_local_files/videos -type f -printf "%f\n" > file_list.txt

  #get all filenames
  youtube-dl $youtube_url -f 22 --get-filename > video_list.txt

  #find local files no longer needed
  grep -Fxv -f video_list.txt file_list.txt > del_list.txt


  # remove files no longer needed
  x=$(cat del_list.txt | wc -l)
  echo "removing $x files"
  i=1

  while [ $i -le $x ]
  do
    current_name=$(sed $i'q;d' del_list.txt)
    echo $current_name
    rm "$HOME/piTube_local_files/videos/$current_name"
    i=`expr $i + 1`
  done
}

#play the videos
PlayVideos () {
  # play files
  if [ "$fullscreen" = true ] ; then
    mplayer -fs $HOME/piTube_local_files/videos/*
  else
     mplayer $HOME/piTube_local_files/videos/*
  fi
}

##########################################
#loop forever
while [ true ]
do
  #start both instances and wait
  CheckAndDL &
  PlayVideos &
  wait
done
##########################################
