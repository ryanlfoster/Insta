#!/bin/sh
#* LoginHook : Payload required.
#+ chris.gerke@gmail.com

ME=$0
RES="$1/Contents/Resources"
ROOT="$3"

#+ // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

#* Detect payload copy, set loginhook
if [ -r "${RES}/PAYLOAD" ]; then
 #+ Payload
 sudo cp -Rf "${RES}/PAYLOAD/" "${ROOT}/Library/Scripts"
 sudo chmod -R 755 "${ROOT}/Library/Scripts/LoginHook.sh"
 sudo chown -R root:wheel "${ROOT}/Library/Scripts/LoginHook.bash"
 sudo chmod -R 755 "${ROOT}/Library/Scripts/LoginHook"
 sudo chown -R root:wheel "${ROOT}/Library/Scripts/LoginHook"
 #+ Loginhook
 sudo defaults write "${ROOT}/var/root/Library/Preferences/com.apple.loginwindow" LoginHook -string "/Library/Scripts/LoginHook.bash"
fi

exit 0
