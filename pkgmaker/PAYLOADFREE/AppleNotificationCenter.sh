#!/bin/sh
# AppleNotificationCenter : Payload free. Disable Notification Center.
# chris.gerke@gmail.com

AGENT="com.apple.notificationcenterui"
#DAEMON="AppleNotificationCenter"

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# LaunchDaemon (daemon because softwareupdate requires root)
#sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" Label "com.cmg.${DAEMON}"
#sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" RunAtLoad -bool TRUE
#sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" ProgramArguments -array "launchctl" "unload" "-w" "/System/Library/LaunchAgents/com.apple.notificationcenterui.plist"
# or this way?

# Disable
[ -e "${ROOT}/System/Library/LaunchAgents/${AGENT}.plist" ] && sudo defaults write "${ROOT}/System/Library/LaunchAgents/${AGENT}" KeepAlive -bool false; sudo chown root:wheel "${ROOT}/System/Library/LaunchAgents/${AGENT}.plist"; sudo chmod 644 "${AGENT}.plist"

# Permissions
#sudo chown root:wheel "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"
#sudo chmod 644 "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist" 

# Load if booted
#if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then sudo launchctl load -w "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"; fi

exit 0