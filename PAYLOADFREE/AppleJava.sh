#!/bin/sh
# AppleJava : Payload free. Stop disabling Java applet plugin and web start apps.
# chris.gerke@gmail.com

AGENT="com.apple.javadisabler"

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Disable
[ -e "${ROOT}/System/Library/LaunchAgents/${AGENT}.plist" ] && sudo defaults write "${ROOT}/System/Library/LaunchAgents/${AGENT}" "RunAtLoad" "No"; sudo chown root:wheel "${ROOT}/System/Library/LaunchAgents/${AGENT}.plist"; sudo chmod 644 "${AGENT}.plist"

exit 0
