#!/bin/sh
# AppleAutoLoginUser : Payload required. Auto login a specified user.
# chris.gerke@gmail.com

ME=$0
RES="$1/Contents/Resources"
ROOT="$3"

AUTOLOGINUSER=$(sudo /usr/bin/defaults read "${RES}/config" autoLoginUser)

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# AUTOLOGINUSER specified?
if [ -z "${AUTOLOGINUSER}" ] || [ "${AUTOLOGINUSER}" != "" ]; then
 # Payload
 if [ -r "${RES}/PAYLOAD/kcpassword" ]; then
  # kcpassword
  sudo /bin/cp -f "${RES}/PAYLOAD/kcpassword" "${ROOT}/etc/kcpassword"
  # Permissions
  sudo /usr/sbin/chown root:wheel "${ROOT}/etc/kcpassword"
  sudo /bin/chmod 600 "${ROOT}/etc/kcpassword"
  sudo /bin/rm -Rf "${ROOT}/etc/kcpassword.disabled"
  # ${ROOT}/Library/Preferences/com.apple.loginwindow.plist
  sudo /usr/bin/defaults write "${ROOT}/Library/Preferences/com.apple.loginwindow" autoLoginUser -string "${AUTOLOGINUSER}"
  sudo /bin/rm -Rf "${ROOT}/Library/Preferences/com.apple.loginwindow.plist.lockfile"
  # Permissions
  sudo /usr/sbin/chown root:wheel "${ROOT}/Library/Preferences/com.apple.loginwindow.plist"
  sudo /bin/chmod 644 "${ROOT}/Library/Preferences/com.apple.loginwindow.plist"
 fi
fi

exit 0