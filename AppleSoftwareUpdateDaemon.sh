#!/bin/sh
# AppleSoftwareUpdate : Payload free. Disable SoftwareUpdate scheduled check.
# chris.gerke@gmail.com

ME=$0
RES="$1/Contents/Resources"
ROOT="$3"
DAEMON="AppleSoftwareUpdate"

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# LaunchDaemon (daemon because softwareupdate requires root)
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" Label "com.cg.${DAEMON}"
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" ProgramArguments -array "/usr/sbin/softwareupdate" "--schedule" "off"

# Permissions
sudo /usr/sbin/chown root:wheel "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"
sudo /bin/chmod 644 "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist" 

# Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then
 sudo /bin/launchctl load -w "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"
fi

exit 0
