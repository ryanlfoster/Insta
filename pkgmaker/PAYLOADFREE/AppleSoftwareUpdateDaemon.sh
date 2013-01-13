#!/bin/sh
# AppleSoftwareUpdate : Payload free. Disable SoftwareUpdate scheduled check.
# chris.gerke@gmail.com

DAEMON="AppleSoftwareUpdate"

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# LaunchDaemon (daemon because softwareupdate requires root)
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" Label "com.cmg.${DAEMON}"
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" RunAtLoad -bool TRUE
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" ProgramArguments -array "/usr/sbin/softwareupdate" "--schedule" "off"

# Permissions
sudo chown root:wheel "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"
sudo chmod 644 "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist" 

# Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then sudo launchctl load -w "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"; fi

exit 0
