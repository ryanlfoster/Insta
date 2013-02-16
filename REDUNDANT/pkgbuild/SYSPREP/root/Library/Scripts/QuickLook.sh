#!/bin/bash

[ -e "/System/Library/LaunchAgents/com.apple.quicklook.plist" ] && sudo /bin/launchctl unload -w /System/Library/LaunchAgents/com.apple.quicklook.plist

sudo srm "$0"