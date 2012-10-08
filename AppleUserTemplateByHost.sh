#!/bin/sh
# AppleUserTemplateByHost : Payload required. Default Apple User Template ByHost preferences.
# chris.gerke@gmail.com

ME=$0
RES="$1/Contents/Resources"
ROOT="$3"

SCREENSAVER="Default.slideSaver"

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

TARGET_OS=$(sudo /usr/bin/defaults read "${ROOT}/System/Library/CoreServices/SystemVersion" ProductVersion)

# Payload
if [ -r "${RES}/PAYLOAD" ]; then
 sudo /bin/mkdir -p "${ROOT}/usr/local/bin"
 sudo /bin/cp -Rf "${RES}/PAYLOAD/AppleMenuExtrasRunOnce" "${ROOT}/usr/local/bin/AppleMenuExtrasRunOnce"
 sudo /bin/cp -Rf "${RES}/PAYLOAD/AppleMultiTouchRunOnce" "${ROOT}/usr/local/bin/AppleMultiTouchRunOnce"
 sudo /bin/cp -Rf "${RES}/PAYLOAD/AppleScreenSaverRunOnce" "${ROOT}/usr/local/bin/AppleScreenSaverRunOnce"
 # Redundant once fully 10.8
 sudo /bin/cp -Rf "${RES}/PAYLOAD/Screensavers/${SCREENSAVER}" "${ROOT}/Library/Screen Savers/${SCREENSAVER}"
fi

# LaunchDaemon
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/AppleMenuExtras" Label "com.cg.AppleMenuExtras"
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/AppleMenuExtras" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/AppleMenuExtras" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/AppleMenuExtrasRunOnce"
# Permissions
sudo /usr/sbin/chown root:wheel "${ROOT}/Library/LaunchDaemons/AppleMenuExtras.plist"
sudo /bin/chmod 644 "${ROOT}/Library/LaunchDaemons/AppleMenuExtras.plist" 
# Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then
 sudo /bin/launchctl load -w "${ROOT}/Library/LaunchDaemons/AppleMenuExtras.plist"
fi

# LaunchDaemon
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/AppleMultiTouchRunOnce" Label "com.cg.AppleMultiTouchRunOnce"
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/AppleMultiTouchRunOnce" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/AppleMultiTouchRunOnce" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/AppleMultiTouchRunOnce"
# Permissions
sudo /usr/sbin/chown root:wheel "${ROOT}/Library/LaunchDaemons/AppleMultiTouchRunOnce.plist"
sudo /bin/chmod 644 "${ROOT}/Library/LaunchDaemons/AppleMultiTouchRunOnce.plist" 
# Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then
 sudo /bin/launchctl load -w "${ROOT}/Library/LaunchDaemons/AppleMultiTouchRunOnce.plist"
fi

# LaunchDaemon
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/AppleScreenSaver" Label "com.cg.AppleScreenSaver"
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/AppleScreenSaver" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/AppleScreenSaver" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/AppleScreenSaverRunOnce"
# Permissions
sudo /usr/sbin/chown root:wheel "${ROOT}/Library/LaunchDaemons/AppleScreenSaver.plist"
sudo /bin/chmod 644 "${ROOT}/Library/LaunchDaemons/AppleScreenSaver.plist" 
# Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then
 sudo /bin/launchctl load -w "${ROOT}/Library/LaunchDaemons/AppleScreenSaver.plist"
fi

exit 0