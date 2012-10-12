#!/bin/bash
# LoginHook : Payload required.
# chris.gerke@gmail.com

LOGINHOOK="$1/Contents/Resources/PAYLOAD/LoginHook.bash"

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Payload
[ -e "$1/Contents/Resources/PAYLOAD/LoginHook.bash" ] && sudo cp -f "$1/Contents/Resources/PAYLOAD/LoginHook.bash" "${ROOT}/Library/Scripts/LoginHook.bash" || exit 1
[ -e "$1/Contents/Resources/PAYLOAD/LoginHook.bash" ] && sudo chown -R root:wheel "${ROOT}/Library/Scripts/LoginHook.bash"
[ -e "$1/Contents/Resources/PAYLOAD/LoginHook.bash" ] && sudo chmod -R 755 "${ROOT}/Library/Scripts/LoginHook.bash"

# Paylod
[ -e "$1/Contents/Resources/PAYLOAD/LoginHook" ] && sudo cp -Rf "$1/Contents/Resources/PAYLOAD/LoginHook/" "${ROOT}/Library/Scripts/LoginHook" || exit 1
[ -e "$1/Contents/Resources/PAYLOAD/LoginHook" ] && sudo chown -R root:wheel "${ROOT}/Library/Scripts/LoginHook"
[ -e "$1/Contents/Resources/PAYLOAD/LoginHook" ] && sudo chmod -R 755 "${ROOT}/Library/Scripts/LoginHook"

# Loginhook
sudo defaults write "${ROOT}/var/root/Library/Preferences/com.apple.loginwindow" LoginHook -string "/Library/Scripts/LoginHook.bash"

exit 0
