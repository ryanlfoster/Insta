#!/bin/sh
# AppleUserTemplate : Payload required. Default Apple User Template preferences.
# chris.gerke@gmail.com

ROOT="$3"
HOMEPAGE="http://intranet.rdigest.com"

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi
TARGET_OS=$(sudo defaults read "${ROOT}/System/Library/CoreServices/SystemVersion" ProductVersion)

# User Template
for USER_TEMPLATE in `sudo ls ${ROOT}/System/Library/User\ Template`
do
 if [ -r "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences" ]; then
  # com.adobe.crashreporter
  sudo defaults write "/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.crashreporter" always_never_send -int 2
  # com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10 dict" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10:AVGeneral dict" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10:AVGeneral:CheckForUpdatesAtStartup array" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10:AVGeneral:CheckForUpdatesAtStartup:0 integer 0" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Set :10:AVGeneral:CheckForUpdatesAtStartup:0 0" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Add :10:AVGeneral:CheckForUpdatesAtStartup:1 bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  sudo /usr/libexec/PlistBuddy -c "Set :10:AVGeneral:CheckForUpdatesAtStartup:1 NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Acrobat.Pro.plist
  # Adobe Lightroom
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.adobe.Lightroom2" noAutomaticallyCheckUpdates -bool true
  # CyberDuck
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" connection.login.useKeychain -string false
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" donate.reminder -string 4.2.1
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" donate.reminder.date -string 1333064699726
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" SUCheckAtStartup -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/ch.sudo.cyberduck" update.check -string FALSE
  # Flip4Mac
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/net.telestream.wmv" UpdateCheck_CheckInterval -int 9999
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/net.telestream.wmv.plugin" ShowController -bool YES
  # Growl
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlDisplayPluginName -string "Music Video"
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlEnabled -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlEnableForward -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlLoggingEnabled -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlMenuExtra -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlStartServer -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" GrowlUpdateCheck -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" StickyWhenAway -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp" com.Growl.MusicVideo -dict
  sudo /usr/libexec/PlistBuddy -c "Add :com.Growl.MusicVideo dict" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  sudo /usr/libexec/PlistBuddy -c "Add :com.Growl.MusicVideo:Duration integer 0" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  sudo /usr/libexec/PlistBuddy -c "Set :com.Growl.MusicVideo:Duration 0" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  sudo /usr/libexec/PlistBuddy -c "Add :com.Growl.MusicVideo:Opacity integer 0" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  sudo /usr/libexec/PlistBuddy -c "Set :com.Growl.MusicVideo:Opacity 0" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.Growl.GrowlHelperApp.plist
  # Microsoft Office
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.microsoft.autoupdate2" HowToCheck -string Manual
  # Stuffit Expander
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.stuffit.StuffIt-Expander" moveToApplicationsFolderAlertSuppress -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.stuffit.StuffIt-Expander" registrationAction -int 2
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.stuffit.StuffIt-Expander" SUEnableAutomaticChecks -bool NO
 fi
done

exit 0