#!/bin/sh
# Server monitor
#

##### INIT START #####
currentdir=$(pwd)
seenlogdir="$currentdir/log"
mkdir $seenlogdir 2>/dev/null
##### INIT END #####



##### PARAMETERS START #####
mittente="servername@gmail.com" # Sender of the email
dest="someone@somewhere.com" # Recipient of the email
smtp="smtp.gmail.com:587" # Default gmail settings

# Credentials to the sender gmail account
username="servername@gmail.com"
pass="VerySecurePassword"


servername="$1" # Name of the server to be checked
ip="$2" # IP of the server to be checked

logdate=$(date +"%m-%Y")
scriptlog="$seenlogdir/script_$logdate_$servername.log"
seendate=$(date +"%d-%m-%Y %H:%M:%S")
seenlog="$seenlogdir/seenlog_$servername.txt"
touch $seenlog
seenboolean="$seenlogdir/seenboolean_$servername.txt"
seen=$(head -1 "$seenlog")

messaggio="Server $servername $ip does not respond to ping since $seen." # Message in case the server is down
oggetto="Server: $servername is down!" # Subject in case the server is down
messaggio2="Server $servername $ip now responds to ping. Was not responding since $seen." # Message in case the server is up
oggetto2="Server: $servername is up" # Subject in case the server is up
inviamail="sendemail -f $mittente -t $dest -u $oggetto -s $smtp -o tls=yes -xu $username -xp $pass -m $messaggio"
inviamail2="sendemail -f $mittente -t $dest -u $oggetto2 -s $smtp -o tls=yes -xu $username -xp $pass -m $messaggio2"
###### PARAMETERS END ######


echo "$(date +"%D %T") : server monitor." >>$scriptlog
echo "Pinging $ip." >>$scriptlog
if fping -c 1 -t 500 $ip >/dev/null
then
  echo "Answer to the ping received from $ip." >>$scriptlog
  if [ ! -f $seenboolean ]
  then
    echo "server was down but now is up. Sending email." >>$scriptlog
    $inviamail2  >>$scriptlog
  else
        :
  fi
  touch $seenboolean
  echo $seendate >$seenlog
else
  echo "No answer received to the ping." >>$scriptlog
  if [ -f $seenboolean ]
  then
    echo "Sending email." >>$scriptlog
    $inviamail  >>$scriptlog
  else
    :
  fi
  rm $seenboolean 2>/dev/null
fi
