#!/bin/sh
# AppleJava : Payload free. Stop disabling Java applet plugin and web start apps.
# chris.gerke@gmail.com

ROOT="$3"

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

JAVAAGENT="${ROOT}/System/Library/LaunchAgents/com.apple.javadisabler"
[ -e "${JAVAAGENT}.plist" ] && sudo defaults write "${JAVAAGENT}" "RunAtLoad" "No"; sudo chown root:wheel "${JAVAAGENT}.plist"; sudo chmod 644 "${JAVAAGENT}.plist"

exit 0
