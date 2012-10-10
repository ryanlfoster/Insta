#!/bin/sh
#* AppleProfiles : Payload required. Profiles.
#+ chris.gerke@gmail.com

DAEMON="AppleProfiles"

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

#* Payload
if [ -r "$1/Contents/Resources/PAYLOAD" ]; then
 sudo mkdir -p "${ROOT}/usr/local/bin"
 sudo cp -Rf "$1/Contents/Resources/PAYLOAD/" "${ROOT}/usr/local/bin"
fi

#+ LaunchDaemon
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" Label "com.cmg.${DAEMON}"
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" RunAtLoad -bool TRUE
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/${DAEMON}"

#+ Permissions
sudo chown root:wheel "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"
sudo chmod 644 "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist" 

#+ Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then sudo launchctl load -w "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"; fi

exit 0