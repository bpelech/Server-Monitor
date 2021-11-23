# Server-Monitor
Bash script that pings a server to check when it goes offline and when it comes back online. Sends email notifications.
Original script by https://github.com/giovi321/Server-Monitor. Changes in this fork:
* added support for multiple servers
* minor tweaks to the original script so the setup is simpler

## Brief explanation of the script
This bash script pings a server. If it receives an answer, it writes down in a file the date and time. If before that the server was down, the script sends an email to notify that the server is up again (checking is the file seenboolean.txt exists). If it doesn't receive an aswer to the ping, the scripts checks if at the previous cycle of the script the server was down. If it was already down, the script doesn't send an email, but if it wasn't down, it sends an email telling when the server was last seen.
In the servers-list.txt you can keep the list of your servers with name and IP address.

## Requirements
* gmail account with less secure app access on
* sendemail with TSL support
* fping

## Installation
* Setup a gmail account and turn on less secure app access (Manage your Google Account -> Security -> Less secure app access)
* sudo apt install sendemail libnet-ssleay-perl libcrypt-ssleay-perl libio-socket-ssl-perl
* sudo apt install fping
* git clone https://github.com/bpelech/Server-Monitor.git
* Edit servermonitor.sh -> change "mittente", "dest", "username" and "pass"
* Edit servers-list.txt -> add your servers. One server per line. Server name is just for you - fping will call IP addresses. Syntax is "servername without space nor special charracters" space "IP address"
* chmod 755 run.sh
* chmod 755 servermonitor.sh
* Test & troubleshoot (test with your server) -> ./servermonitor.sh servername 10.10.10.10
* Once everything is going well (you recieved email notifications) move to test the run.sh script and set it up in the crontab

Tested under Ubuntu 20.04.3 LTS 

## Create crontab job
* crontab -e
* Paste at the end the following line if you want to execute it every 5 minutes

*/5 * * * * /path/to/the/script/run.sh

* Paste at the end the following line if you want to execute it every 30 minutes

*/30 * * * * /path/to/the/script/run.sh

* Paste at the end the following line if you want to execute it every hour

@hourly /path/to/the/script/run.sh
