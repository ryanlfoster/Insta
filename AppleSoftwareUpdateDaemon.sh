#!/bin/sh
#* AppleSoftwareUpdate
#+ chris.gerke@gmail.com
#+
#+ Description: Payload free. Disable SoftwareUpdate scheduled check.
#+
#+ Version: 1.1
#+
#+ History:
#+     1.0: Script.
#+     1.1: DAEMON var to make it a little more dynamic.
#+
#+ TODO:
#+     * Add error checking?

ME=$0
SCRIPT_DIR="$1/Contents/Resources"
TARGET_DIR="$3"
DAEMON="AppleSoftwareUpdate"

#+ // fix
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

#+ LaunchDaemon (daemon because softwareupdate requires root)
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}" Label "com.cg.${DAEMON}"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}" ProgramArguments -array "/usr/sbin/softwareupdate" "--schedule" "off"

#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}.plist" 

#+ Load if booted
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "" ]; then
 sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}.plist"
fi

exit 0
