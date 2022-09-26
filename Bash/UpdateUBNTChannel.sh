#!/bin/bash
user="ubnt"
ip="192.168.1.1"
freq="5.490G"
freqc="5520"

output=$(ssh $user@$ip -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa 'iwconfig ath0 | grep -wo Frequency:'${freq:0:4}' | wc -l')

if [ $output -eq 0 ]

then

echo $(date +"%Y%m%d-%H%M%S") "NOT ON $freq, Switch is needed"

/usr/local/emhttp/webGui/scripts/notify -s "Dish Frequecy has changed" -i "alert" -m "Dish is not on the desired frequecy of $freq"  -d "Dish is not on the desired frequecy of $freq"

outputu=$(ssh $user@$ip -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa 'grep -n "Radar found on freq.*.'$freqc'" /var/log/messages | tail -1 | cut -f1 -d:')

[ "$outputu" = '' ] && outputu=0

outputa=$(ssh $user@$ip -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa 'grep -n "Non Occupancy List entry expired for freq.*.'$freqc'" /var/log/messages | tail -1 | cut -f1 -d:')

[ "$outputa" = '' ] && outputa=0

if [ $outputa -ge $outputu ]

then

echo $(date +"%Y%m%d-%H%M%S") "$freq is available, SWITCHING"

outputc=$(ssh $user@$ip -o HostKeyAlgorithms=+ssh-rsa -o PubkeyAcceptedKeyTypes=+ssh-rsa 'iwconfig ath0 freq '$freq)

echo $outputc

/usr/local/emhttp/webGui/scripts/notify -s "Dish Frequecy has changed" -i "normal" -m "Dish is being reset to frequecy: $freq"  -d "Dish is being reset to frequecy: $freq"

exit 1

else

echo $(date +"%Y%m%d-%H%M%S") "$freq is not available, NOT SWITCHING"

/usr/local/emhttp/webGui/scripts/notify -s "Dish Frequecy has changed" -i "warning" -m "$freq is not free"  -d "Dish frequecy $freq is not available, will try again in 24 hours"

exit 1

fi

else

echo $(date +"%Y%m%d-%H%M%S") "ON $freq, No change required"

fi
echo
