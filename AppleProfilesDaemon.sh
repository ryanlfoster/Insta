#!/bin/sh
#* AppleProfiles
#+ chris.gerke@gmail.com
#+
#+ Description: Payload required. Profiles.
#+
#+ Version: 1.1
#+
#+ History:
#+     1.0: Script.
#+     1.1: DAEMON var to make it a little more dynamic.
#+
#+ TODO:
#+     * Add more error checking?
#+     * Think about editing existing users?

ME=$0
SCRIPT_DIR="$1/Contents/Resources"
TARGET_DIR="$3"
DAEMON="AppleProfiles"

VPN="VPN.mobileconfig"
WIFI="WIFI.mobileconfig"

#+ // fix
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "/" ]; then
 TARGET_DIR=""
fi

#* Payload
if [ -r "${SCRIPT_DIR}/PAYLOAD" ]; then
 #+ Target
 sudo /bin/mkdir -p "${TARGET_DIR}/usr/local/bin"
 #+ Payload
 sudo /bin/cp -Rf "${SCRIPT_DIR}/PAYLOAD/" "${TARGET_DIR}/usr/local/bin"
fi

#+ LaunchDaemon
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}" Label "com.cg.${DAEMON}"
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/AppleProfilesRunOnceSelfDestruct"

#+ Permissions
sudo /usr/sbin/chown root:wheel "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}.plist"
sudo /bin/chmod 644 "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}.plist" 

#+ Load if booted
if [ -z "${TARGET_DIR}" ] || [ "${TARGET_DIR}" = "" ]; then
 sudo /bin/launchctl load -w "${TARGET_DIR}/Library/LaunchDaemons/${DAEMON}.plist"
fi

exit 0