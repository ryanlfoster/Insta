#!/bin/bash

[ -e "/System/Library/LaunchAgents/com.apple.notificationcenterui.plist" ] && sudo /bin/launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist

sudo srm "$0"