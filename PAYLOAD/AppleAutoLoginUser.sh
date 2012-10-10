#!/bin/sh
# AppleAutoLoginUser : Payload required. Auto login a specified user.
# chris.gerke@gmail.com

SHORTNAME=""

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Multi OS
TARGET_OS=$(sudo defaults read "${ROOT}/System/Library/CoreServices/SystemVersion" ProductVersion)

# Payload
[ -e "$1/Contents/Resources/PAYLOAD/kcpassword.${TARGET_OS}" ] && sudo cp -f "$1/Contents/Resources/PAYLOAD/kcpassword" "${ROOT}/etc/kcpassword"; echo "Payload"
[ -e "${ROOT}/etc/kcpassword" ] && sudo chown root:wheel "${ROOT}/etc/kcpassword"
[ -e "${ROOT}/etc/kcpassword" ] && sudo chmod 600 "${ROOT}/etc/kcpassword"
[ -e "${ROOT}/etc/kcpassword.disabled" ] && sudo rm -Rf "${ROOT}/etc/kcpassword.disabled"
 
# com.apple.loginwindow.plist
[ -e "${ROOT}/etc/kcpassword" ] || [ -z "${SHORTNAME}" ] || [ "${SHORTNAME}" != "" ] && sudo defaults write "${ROOT}/Library/Preferences/com.apple.loginwindow" autoLoginUser -string "${SHORTNAME}"; sudo rm -Rf "${ROOT}/Library/Preferences/com.apple.loginwindow.plist.lockfile"; sudo chown root:wheel "${ROOT}/Library/Preferences/com.apple.loginwindow.plist"; sudo chmod 644 "${ROOT}/Library/Preferences/com.apple.loginwindow.plist"; echo "autoLoginUser"

exit 0