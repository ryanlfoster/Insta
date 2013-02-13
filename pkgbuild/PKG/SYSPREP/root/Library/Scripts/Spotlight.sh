#!/bin/bash

sudo mdutil -a -i off
sudo mdutil -a -i off /Volumes/*
sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist

sudo srm "$0"