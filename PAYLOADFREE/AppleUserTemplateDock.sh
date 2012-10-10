#!/bin/sh
# AppleUserTemplate : Payload free. Default Apple User Template preferences.
# chris.gerke@gmail.com

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Multi OS
TARGET_OS=$(sudo defaults read "${ROOT}/System/Library/CoreServices/SystemVersion" ProductVersion)

# User Template
for USER_TEMPLATE in `sudo ls ${ROOT}/System/Library/User\ Template`
do
 if [ -r "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences" ]; then
  
# Start ugly. I will work on making it nicer when I have time.
sudo cat > "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.dock.plist" << EOPROFILE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>autohide</key>
	<false/>
	<key>launchanim</key>
	<false/>
	<key>mineffect</key>
	<string>scale</string>
	<key>mod-count</key>
	<integer>6</integer>
	<key>persistent-apps</key>
	<array/>
	<key>persistent-others</key>
	<array/>
	<key>version</key>
	<integer>1</integer>
</dict>
</plist>
EOPROFILE
# End ugly
  
 fi
done

exit 0