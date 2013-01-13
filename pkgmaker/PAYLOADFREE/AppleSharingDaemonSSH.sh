#!/bin/sh
# AppleSharing : Payload free. SSH Daemon.
# chris.gerke@gmail.com

DAEMON="AppleSharingSSH"

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# LaunchDaemon
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" Label "com.cmg.${DAEMON}"
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" RunAtLoad -bool TRUE
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" ProgramArguments -array "/usr/sbin/systemsetup" "-setremotelogin" "on"

# Permissions
sudo chown root:wheel "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"
sudo chmod 644 "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"

# Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then sudo launchctl load -w "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"; fi

exit 0
