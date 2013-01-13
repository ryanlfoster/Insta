#!/bin/bash
# AppleProfiles : Payload required. Profiles.
# chris.gerke@gmail.com

PROFILE="WiFi"
DAEMON="AppleProfiles${PROFILE}"

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Payload
[ -e "$1/Contents/Resources/PAYLOAD/${PROFILE}.mobileconfig" ] && sudo cp -Rf "$1/Contents/Resources/PAYLOAD/" "${ROOT}/usr/local/bin" || exit 1

# LaunchDaemon
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" Label "com.cmg.${DAEMON}"
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" RunAtLoad -bool TRUE
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/${DAEMON}"

# Permissions
[ -e "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist" ] && sudo chown root:wheel "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"
[ -e "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist" ] && sudo chmod 644 "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"

# Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then sudo launchctl load -w "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"; fi

exit 0