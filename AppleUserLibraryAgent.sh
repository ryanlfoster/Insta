#!/bin/sh
# AppleUserLibrary : Payload free. Unhide ~/Library.
# chris.gerke@gmail.com

ME=$0
RES="$1/Contents/Resources"
ROOT="$3"
AGENT="AppleUserLibrary"

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# LaunchAgent
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" Label "com.cg.${AGENT}"
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" ProgramArguments -array "/bin/sh" "-c" "/bin/sleep 10; /usr/bin/chflags nohidden ~/Library"

# Permissions
sudo /usr/sbin/chown root:wheel "${ROOT}/Library/LaunchAgents/${AGENT}.plist"
sudo /bin/chmod 644 "${ROOT}/Library/LaunchAgents/${AGENT}.plist"

# Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then
 sudo /bin/launchctl load -w "${ROOT}/Library/LaunchAgents/${AGENT}.plist"
fi

exit 0
