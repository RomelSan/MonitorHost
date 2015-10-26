#!/bin/bash
# Shell script for Linux and UNIX system monitoring with Ping command
# -------------------------------------------------------------------------
# Copyright (c) 2015 Romel Vera Cadena <http://www.github.com/romelsan>
# This script is licensed under MIT
# -------------------------------------------------------------------------
export LOG_LEVEL=3

# Add ip / hostname separated by space 
HOSTS="google.com 192.168.0.100 192.168.0.101"
 
# Number of Ping Packets to server (Maximum recommended 2)
PINGS=1
 
# Should I send Email when host is down?
SUBJECT="Ping failed"
EMAILID="my_email@gmail.com"
SEND_EMAIL=0

# Should I log to a file?
LOG=0

#Should I clear the screen before posting results?
CLEAR=1

# ------------------------------------------DO NOT MODIFY BELOW -----------------------------------------
#Code
COUNT=1
ALERT=""
DATA_LOG=""
LINE="\e[1mDate;   Host;Status\e[0m\n"
echo -e "\n\e[41mChecking...\e[49m"
for myHost in $HOSTS
	do
		COUNT=$(ping -c $PINGS $myHost | grep 'received' | awk -F',' '{ print $2 }' | awk '{ print $1 }')
		if [ $COUNT -eq 0 ]; then
			# 100% Failed (0 Packets Response)
			LINE+="At $(date);\e[94m$myHost ;\e[39m[\e[91mDown\e[39m]\n"
			#echo -e "$LINE" | column -t -s ';'
		fi
		
		if [ $COUNT -ne 0 ]; then
			# 100% or 50% (Latency) OK 
			LINE+="At $(date);\e[94m$myHost ;\e[39m[\e[92mOK\e[39m]\n"
			#echo -e "$LINE" | column -t -s ';'
		fi
			
		if [ $SEND_EMAIL -eq 1 ] && [ $COUNT -eq 0 ]; then
			ALERT+="Host: $myHost is down (ping failed) at $(date)\n" 
			#echo -e "$ALERT" | mail -s "$SUBJECT" "$EMAILID"
		fi		
		
		if [ $LOG -eq 1 ] && [ $COUNT -eq 0 ]; then
			DATA_LOG+="Host: $myHost is down at $(date)\n" 
			#echo -e "$ALERT" | mail -s "$SUBJECT" "$EMAILID"
		fi		
	done

# Check Clear Screen
if [ $CLEAR -eq 1 ]; then
	clear
fi		

# Display Results
echo -e "\n"
echo -e "$LINE" | column -c 3 -t -s ';'
echo -e ""

# Email Results
if [ $SEND_EMAIL -eq 1 ]; then
	echo -e "$ALERT" | mail -s "$SUBJECT" "$EMAILID"
fi		

# Save to LOG 
if [ $LOG -eq 1 ]; then
	NOW=$(date +"%F")
	LOGFILE="log-$NOW.log"
	echo -e "$DATA_LOG" >> $LOGFILE
fi		
