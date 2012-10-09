#!/bin/sh
# AppleNotificationCenter : Payload free. Disable Notification Center.
# chris.gerke@gmail.com

ROOT="$3"
#DAEMON="AppleNotificationCenter"

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# LaunchDaemon (daemon because softwareupdate requires root)
#sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" Label "com.cmg.${DAEMON}"
#sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" RunAtLoad -bool TRUE
#sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" ProgramArguments -array "launchctl" "unload" "-w" "/System/Library/LaunchAgents/com.apple.notificationcenterui.plist"
# or this way?
[ -e "${ROOT}/System/Library/LaunchAgents/com.apple.notificationcenterui.plist" ] && sudo defaults write "${ROOT}/System/Library/LaunchAgents/com.apple.notificationcenterui" KeepAlive -bool false

# Permissions
#sudo chown root:wheel "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"
#sudo chmod 644 "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist" 

# Load if booted
#if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then sudo launchctl load -w "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"; fi

exit 0