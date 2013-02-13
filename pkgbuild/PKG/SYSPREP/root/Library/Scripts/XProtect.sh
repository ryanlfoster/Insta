#!/bin/bash

[ -e "/System/Library/LaunchDaemons/com.apple.xprotectupdater.plist" ] && sudo /bin/launchctl unload -w /System/Library/LaunchDaemons/com.apple.xprotectupdater.plist

sudo srm "$0"