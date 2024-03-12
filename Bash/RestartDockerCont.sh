#!/bin/bash

# run as sudo

stopped= docker container list --filter "label=docker-volume-backup.stop-during-backup=true" --filter status=exited --quiet