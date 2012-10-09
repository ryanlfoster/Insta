#!/bin/sh
# AppleAutoLoginUser : Payload required. Auto login a specified user.
# chris.gerke@gmail.com

ME=$0
RES="$1/Contents/Resources"
ROOT="$3"
AUTOLOGINUSER=$(sudo defaults read "${RES}/config" autoLoginUser)

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

if [ -z "${AUTOLOGINUSER}" ] || [ "${AUTOLOGINUSER}" != "" ]; then
 # Payload
 if [ -r "${RES}/PAYLOAD/kcpassword" ]; then
  # kcpassword
  sudo cp -f "${RES}/PAYLOAD/kcpassword" "${ROOT}/etc/kcpassword"
  sudo chown root:wheel "${ROOT}/etc/kcpassword"
  sudo chmod 600 "${ROOT}/etc/kcpassword"
  sudo rm -Rf "${ROOT}/etc/kcpassword.disabled"
  # com.apple.loginwindow.plist
  sudo defaults write "${ROOT}/Library/Preferences/com.apple.loginwindow" autoLoginUser -string "${AUTOLOGINUSER}"
  sudo rm -Rf "${ROOT}/Library/Preferences/com.apple.loginwindow.plist.lockfile"
  sudo chown root:wheel "${ROOT}/Library/Preferences/com.apple.loginwindow.plist"
  sudo chmod 644 "${ROOT}/Library/Preferences/com.apple.loginwindow.plist"
 fi
fi

exit 0