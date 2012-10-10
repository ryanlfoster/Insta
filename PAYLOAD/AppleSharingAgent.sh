#!/bin/bash
# AppleSharing : Payload required. Apple Remote Assistance.
# chris.gerke@gmail.com

AGENT="AppleSharing"

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Payload
[ -e "$1/Contents/Resources/PAYLOAD/ard" ] && sudo cp -f "$1/Contents/Resources/PAYLOAD/ard" "${ROOT}/usr/local/bin/ard" || exit 1

# Permissions
[ -e "${ROOT}/usr/local/bin/ard" ] && sudo chown root:wheel "${ROOT}/usr/local/bin/ard"
[ -e "${ROOT}/usr/local/bin/ard" ] && sudo chmod 755 "${ROOT}/usr/local/bin/ard"
[ -e "${ROOT}/usr/local/bin/ard" ] && sudo chmod u+s "${ROOT}/usr/local/bin/ard"

# Payload
[ -e "$1/Contents/Resources/PAYLOAD/ardon" ] && sudo cp -f "$1/Contents/Resources/PAYLOAD/ardon" "${ROOT}/usr/local/bin/ardon" || exit 1

# Permissions
[ -e "${ROOT}/usr/local/bin/ardon" ] && sudo chown root:wheel "${ROOT}/usr/local/bin/ardon"
[ -e "${ROOT}/usr/local/bin/ardon" ] && sudo chmod 755 "${ROOT}/usr/local/bin/ardon"
[ -e "${ROOT}/usr/local/bin/ardon" ] && sudo chmod u+s "${ROOT}/usr/local/bin/ardon"

# Payload
[ -e "$1/Contents/Resources/PAYLOAD/ardoff" ] && sudo cp -f "$1/Contents/Resources/PAYLOAD/ardoff" "${ROOT}/usr/local/bin/ardoff" || exit 1

# Permissions
[ -e "${ROOT}/usr/local/bin/ardoff" ] && sudo chown root:wheel "${ROOT}/usr/local/bin/ardoff"
[ -e "${ROOT}/usr/local/bin/ardoff" ] && sudo chmod 755 "${ROOT}/usr/local/bin/ardoff"
[ -e "${ROOT}/usr/local/bin/ardoff" ] && sudo chmod u+s "${ROOT}/usr/local/bin/ardoff"

# Payload
[ -e "$1/Contents/Resources/PAYLOAD/sshon" ] && sudo cp -f "$1/Contents/Resources/PAYLOAD/sshon" "${ROOT}/usr/local/bin/sshon" || exit 1

# Permissions
[ -e "${ROOT}/usr/local/bin/sshon" ] && sudo chown root:wheel "${ROOT}/usr/local/bin/sshon"
[ -e "${ROOT}/usr/local/bin/sshon" ] && sudo chmod 755 "${ROOT}/usr/local/bin/sshon"
[ -e "${ROOT}/usr/local/bin/sshon" ] && sudo chmod u+s "${ROOT}/usr/local/bin/sshon"

# LaunchAgent
sudo defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" Label "com.cmg.${AGENT}"
sudo defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" RunAtLoad -bool TRUE
sudo defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/ard"

# Permissions
[ -e "${ROOT}/Library/LaunchAgents/${AGENT}.plist" ] && sudo /usr/sbin/chown root:wheel "${ROOT}/Library/LaunchAgents/${AGENT}.plist"
[ -e "${ROOT}/Library/LaunchAgents/${AGENT}.plist" ] && sudo /bin/chmod 644 "${ROOT}/Library/LaunchAgents/${AGENT}.plist"

# Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then sudo launchctl load -w "${ROOT}/Library/LaunchAgents/${AGENT}.plist"; fi

exit 0
