#!/bin/bash
#Hosts Discovery on a /24 network - bash interactive utility

read -p "/24 Hosts Discovery on (v)pn or (l)an? " answer

if [ "$answer" == "v" ] 
then
    networkID="10.10.10." #adjust to yours
elif [ "$answer" == "l" ] 
then
    networkID="192.168.0." #adjust to yours  
else
    echo "Insert a valid answer (just one letter: \"v\" or \"l\")" 1>&2
    exit 1
fi

for hostID in $(seq 2 254); do #check every usable IP on the /24 network;
    timeout 1 bash -c "ping -c 1 $networkID$hostID 1>/dev/null 2>&1" && echo "$networkID$hostID is on!" &
    #If ping doesnt receive an answer in less than one second then that IP is off.
    #Redirecting ping stdout and stderr to /dev/null
done; wait