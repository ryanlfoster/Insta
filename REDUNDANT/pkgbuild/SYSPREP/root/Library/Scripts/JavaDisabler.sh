#!/bin/bash

[ -e "/System/Library/LaunchAgents/com.apple.javadisabler.plist" ] && sudo /bin/launchctl unload -w /System/Library/LaunchAgents/com.apple.javadisabler.plist

sudo srm "$0"