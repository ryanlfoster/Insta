#!/bin/sh
#* AppleUserLibrary : Payload free. Unhide ~/Library.
#+ chris.gerke@gmail.com

ROOT="$3"
AGENT="AppleUserLibrary"

#+ // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

#+ LaunchAgent
sudo defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" Label "com.cmg.${AGENT}"
sudo defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" RunAtLoad -bool TRUE
sudo defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" ProgramArguments -array "/bin/sh" "-c" "/bin/sleep 10; /usr/bin/chflags nohidden ~/Library"

#+ Permissions
sudo chown root:wheel "${ROOT}/Library/LaunchAgents/${AGENT}.plist"
sudo chmod 644 "${ROOT}/Library/LaunchAgents/${AGENT}.plist"

#+ Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then sudo launchctl load -w "${ROOT}/Library/LaunchAgents/${AGENT}.plist"; fi


exit 0
