#!/bin/sh
# AppleSharing : Payload required. VNC Password.
# chris.gerke@gmail.com

CONFIG=$(sudo defaults read "$1/Contents/Resources/config" VNCP)

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# VNC Password
sudo echo "${CONFIG}" > "${ROOT}/Library/Preferences/com.apple.VNCSettings.txt"

# VNC Permissions
sudo chown -R root:wheel "${ROOT}/Library/Preferences/com.apple.VNCSettings.txt"
sudo chmod -R 600 "${ROOT}/Library/Preferences/com.apple.VNCSettings.txt"

exit 0
