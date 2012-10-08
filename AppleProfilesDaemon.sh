#!/bin/sh
# AppleProfiles : Payload required. Profiles.
# chris.gerke@gmail.com

ME=$0
RES="$1/Contents/Resources"
ROOT="$3"
DAEMON="AppleProfiles"

VPN="VPN.mobileconfig"
WIFI="WIFI.mobileconfig"

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

#* Payload
if [ -r "${RES}/PAYLOAD" ]; then
 sudo /bin/mkdir -p "${ROOT}/usr/local/bin"
 sudo /bin/cp -Rf "${RES}/PAYLOAD/" "${ROOT}/usr/local/bin"
fi

# LaunchDaemon
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" Label "com.cg.${DAEMON}"
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/AppleProfilesRunOnceSelfDestruct"

# Permissions
sudo /usr/sbin/chown root:wheel "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"
sudo /bin/chmod 644 "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist" 

# Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then
 sudo /bin/launchctl load -w "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"
fi

exit 0