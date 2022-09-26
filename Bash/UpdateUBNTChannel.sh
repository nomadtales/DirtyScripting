user="ubnt"
ip="192.168.1.1"
freq="5.490G"


output=$(ssh $user@$ip -o HostKeyAlgorithms=+ssh-rsa 'iwconfig ath0 | grep -wo Frequency:5.675 | wc -l')

if [ $output -eq 0 ]

then 

echo $(date +"%Y%m%d-%H%M%S") "NOT ON DFS, SHOULD BE SWITCHING"

outputu=$(ssh $user@$ip -o HostKeyAlgorithms=+ssh-rsa 'grep -n "Radar found on freq $freq" /var/log/messages | tail -1 | cut -f1 -d:')

[ "$outputu" = '' ] && outputu=0

outputa=$(ssh $user@$ip -o HostKeyAlgorithms=+ssh-rsa 'grep -n "Non Occupancy List entry expired for freq $freq" /var/log/messages | tail -1 | cut -f1 -d:')

[ "$outputa" = '' ] && outputa=0

if [ $outputa -ge $outputu ]

then

echo $(date +"%Y%m%d-%H%M%S") "DFS Channel available (again), SWITCHING"

outputc=$(ssh $user@$ip -o HostKeyAlgorithms=+ssh-rsa 'iwconfig ath0 freq $freq')

echo $outputc

exit 1

else

echo $(date +"%Y%m%d-%H%M%S") "DFS channel not (yet) available, NOT SWITCHING, staying on fallback channel)"

exit 1

fi

else

echo $(date +"%Y%m%d-%H%M%S") "ON DFS"

fi