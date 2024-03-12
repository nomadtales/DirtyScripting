#!/bin/bash

# run as sudo

# capture the exited offen volume backup docker containers
exited=($(docker container list --filter "label=docker-volume-backup.stop-during-backup=true" --filter status=exited --quiet))

# loop through the containers and start
for i in "${exited[@]}"
do
    echo "$i"
done