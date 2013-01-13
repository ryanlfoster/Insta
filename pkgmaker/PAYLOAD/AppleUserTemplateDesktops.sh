#!/bin/sh
#* AppleUserTemplate : Payload required. Default Apple User Template preferences.
#+ chris.gerke@gmail.com

ME=$0
RES="$1/Contents/Resources"
ROOT="$3"

DESKTOP=$(sudo defaults read "${RES}/config" DESKTOP)
DESKTOP_DIR=$(sudo defaults read "${RES}/config" DESKTOP_DIR)

#+ // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi
TARGET_OS=$(sudo /usr/bin/defaults read "${ROOT}/System/Library/CoreServices/SystemVersion" ProductVersion)

#* Detect payload & copy
if [ -r "${RES}/PAYLOAD" ]; then
 #+ Target
 sudo mkdir -p "${ROOT}/${DESKTOP_DIR}"
 #+ Payload
 sudo cp -Rf "${RES}/PAYLOAD/Desktops/" "${ROOT}/${DESKTOP_DIR}"
fi

#+ Loop ${ROOT}/System/Library/User Template
for USER_TEMPLATE in `sudo ls ${ROOT}/System/Library/User\ Template`
do
 if [ -r "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences" ]; then
  
  #+ OK, so this is really ugly. I will work on making it nicer when I have time.
  sudo cat > "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.desktop.plist" << EOPROFILE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>Background</key>
	<dict>
		<key>default</key>
		<dict>
			<key>BackgroundColor</key>
			<array>
				<real>0.0</real>
				<real>0.0</real>
				<real>0.0</real>
			</array>
			<key>DrawBackgroundColor</key>
			<true/>
			<key>ImageFilePath</key>
			<string>${DESKTOP_DIR}/${DESKTOP}</string>
			<key>Placement</key>
					<string>Centered</string>
		</dict>
		<key>spaces</key>
		<dict>
			<key></key>
			<dict>
				<key>0</key>
				<dict>
					<key>BackgroundColor</key>
					<array>
						<real>0.0</real>
						<real>0.0</real>
						<real>0.0</real>
					</array>
					<key>DSKDesktopPrefPane</key>
					<dict>
						<key>UserFolderPaths</key>
						<array>
							<string>${DESKTOP_DIR}</string>
						</array>
					</dict>
					<key>DrawBackgroundColor</key>
					<true/>
					<key>ImageFilePath</key>
					<string>${DESKTOP_DIR}/${DESKTOP}</string>
					<key>Placement</key>
					<string>Centered</string>
				</dict>
				<key>default</key>
				<dict>
					<key>BackgroundColor</key>
					<array>
						<real>0.0</real>
						<real>0.0</real>
						<real>0.0</real>
					</array>
					<key>ChangePath</key>
					<string>${DESKTOP_DIR}</string>
					<key>DrawBackgroundColor</key>
					<true/>
					<key>ImageFilePath</key>
					<string>${DESKTOP_DIR}/${DESKTOP}</string>
					<key>NoImage</key>
					<false/>
					<key>Placement</key>
					<string>Centered</string>
					<key>Random</key>
					<false/>
				</dict>
			</dict>
		</dict>
	</dict>
</dict>
</plist>

EOPROFILE
# End the ugliness
 
 fi
done

exit 0