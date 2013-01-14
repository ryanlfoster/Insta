#!/bin/bash
# chris.gerke@gmail.com

SERIAL=$(ioreg -c IOPlatformExpertDevice | sed -E -n -e '/IOPlatformSerialNumber/{s/^.*[[:space:]]"IOPlatformSerialNumber" = "(.+)"$/\1/p;q;}')
MACADDRESS=$(networksetup -getMACADDRESS en0 | awk '{print $3}' | sed s/://g)

sudo scutil --set ComputerName "${SERIAL}-${MACADDRESS}"
sudo scutil --set LocalHostName "${SERIAL}-${MACADDRESS}"
sudo scutil --set HostName "${SERIAL}-${MACADDRESS}"
sudo hostname "${SERIAL}-${MACADDRESS}"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName "${SERIAL}"

#+ Self destruct?
sudo srm "$0"