#!/bin/sh
# AppleAutoLoginUser : Payload required. Auto login a specified user.
# chris.gerke@gmail.com

CONFIG=$(sudo defaults read "$1/Contents/Resources/config" autoLoginUser)
KCPASSWORD="$1/Contents/Resources/PAYLOAD/kcpassword"

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Multi OS
TARGET_OS=$(sudo defaults read "${ROOT}/System/Library/CoreServices/SystemVersion" ProductVersion)

if [ -z "${CONFIG}" ] || [ "${CONFIG}" != "" ]; then
 # Payload
 if [ -r "${KCPASSWORD}" ]; then
  # kcpassword
  sudo cp -f "${KCPASSWORD}" "${ROOT}/etc/kcpassword"
  sudo chown root:wheel "${ROOT}/etc/kcpassword"
  sudo chmod 600 "${ROOT}/etc/kcpassword"
  sudo rm -Rf "${ROOT}/etc/kcpassword.disabled"
  # com.apple.loginwindow.plist
  sudo defaults write "${ROOT}/Library/Preferences/com.apple.loginwindow" autoLoginUser -string "${CONFIG}"
  sudo rm -Rf "${ROOT}/Library/Preferences/com.apple.loginwindow.plist.lockfile"
  sudo chown root:wheel "${ROOT}/Library/Preferences/com.apple.loginwindow.plist"
  sudo chmod 644 "${ROOT}/Library/Preferences/com.apple.loginwindow.plist"
 fi
fi

exit 0