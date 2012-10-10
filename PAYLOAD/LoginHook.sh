#!/bin/sh
# LoginHook : Payload required.
# chris.gerke@gmail.com

LOGINHOOK="$1/Contents/Resources/PAYLOAD/LoginHook.bash"

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Detect payload copy, set loginhook
if [ -r "${LOGINHOOK}" ]; then
 # Payload
 sudo cp -Rf "${RES}/PAYLOAD/" "${ROOT}/Library/Scripts"
 sudo chmod -R 755 "${ROOT}/Library/Scripts/LoginHook.sh"
 sudo chown -R root:wheel "${ROOT}/Library/Scripts/LoginHook.bash"
 sudo chmod -R 755 "${ROOT}/Library/Scripts/LoginHook"
 sudo chown -R root:wheel "${ROOT}/Library/Scripts/LoginHook"
 # Loginhook
 sudo defaults write "${ROOT}/var/root/Library/Preferences/com.apple.loginwindow" LoginHook -string "/Library/Scripts/LoginHook.bash"
fi

exit 0
