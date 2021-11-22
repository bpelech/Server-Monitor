#!/bin/sh
# Server monitor - main script
#

##### INIT START #####
currentdir=$(pwd)
seenlogdir="$currentdir/log"
mkdir $seenlogdir 2>/dev/null
serverslistfile="$currentdir/servers-list.txt"
logdate=$(date +"%m-%Y")
scriptlog="$seenlogdir/script_$logdate.log"
##### INIT END #####

if [ ! -f $serverslistfile ]
then
    echo "FATAL ERROR: Servers list does not exists!!!"
    echo "$(date +"%D %T") : FATAL ERROR: Servers list does not exists!!!" >>$scriptlog
else
    while read line; do "$currentdir/servermonitor.sh" $line; done < $serverslistfile
fi
