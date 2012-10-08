#!/bin/sh
# AppleJava : Payload free. Stop disabling Java applet plugin and web start apps.
# chris.gerke@gmail.com

ME=$0
RES="$1/Contents/Resources"
ROOT="$3"

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Disable javadisabler LaunchAgent
sudo /usr/bin/defaults write "${ROOT}/System/Library/LaunchAgents/com.apple.javadisabler" "RunAtLoad" "No"
sudo /usr/sbin/chown root:wheel "${ROOT}/System/Library/LaunchAgents/com.apple.javadisabler.plist"
sudo /bin/chmod 644 "${ROOT}/System/Library/LaunchAgents/com.apple.javadisabler.plist"

exit 0
