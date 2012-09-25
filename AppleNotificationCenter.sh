#!/bin/sh
#* AppleNotificationCenter
#+ chris.gerke@gmail.com
#+
#+ Description: Payload free. Disable Notification Center.
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
DAEMON="AppleNotificationCenter"

#+ // fix
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

#+ LaunchDaemon (daemon because softwareupdate requires root)
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}" Label "com.cg.${DAEMON}"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}" RunAtLoad -bool TRUE
#+ This way?
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}" ProgramArguments -array "/bin/launchctl" "unload" "-w" "/System/Library/LaunchAgents/com.apple.notificationcenterui.plist"
#+ or this way and avoid a LaunchDaemon completely?
#sudo /usr/bin/defaults write "${TARGET_DIR}/System/Library/LaunchAgents/com.apple.notificationcenterui" KeepAlive -bool false
#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}.plist" 
#+ Load if booted
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "" ]; then
 sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}.plist"
fi

exit 0