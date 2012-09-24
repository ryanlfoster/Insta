#!/bin/sh
#* AppleUserLibrary
#+ chris.gerke@gmail.com
#+
#+ Description: Payload free. Unhide ~/Library.
#+
#+ Version: 1.1
#+
#+ History:
#+     1.0: Script.
#+     1.1: AGENT var to make it a little more dynamic.
#+
#+ TODO:
#+     * Add error checking?

ME=$0
SCRIPT_DIR="$1/Contents/Resources"
TARGET_DIR="$3"
AGENT="AppleUserLibrary"

#+ // fix
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

#+ LaunchAgent
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchAgents/${AGENT}" Label "com.cg.${AGENT}"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchAgents/${AGENT}" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchAgents/${AGENT}" ProgramArguments -array "/bin/sh" "-c" "/bin/sleep 10; /usr/bin/chflags nohidden ~/Library"

#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchAgents/${AGENT}.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchAgents/${AGENT}.plist"

#+ Load if booted
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "" ]; then
 sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchAgents/${AGENT}.plist"
fi

exit 0
