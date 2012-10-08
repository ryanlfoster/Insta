#!/bin/sh
# LoginHook : Payload required.
# chris.gerke@gmail.com

PAYLOAD="$1/Contents/Resources/PAYLOAD"
ROOT="$3"

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

TARGET="${ROOT}/Library/Scripts"
LHK="/Library/Scripts/LoginHook.bash"

[ -e "${PAYLOAD}" ] && sudo cp -Rf "${PAYLOAD}/" "${TARGET}"; sudo chmod -R 755 "${LHK}"; sudo chown -R root:wheel "${LHK}"
[ -e "${LHK}" ] && sudo defaults write "${ROOT}/var/root/Library/Preferences/com.apple.loginwindow" LoginHook -string "${LHK}"

exit 0