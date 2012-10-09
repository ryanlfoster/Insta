#!/bin/sh
#* AppleSharing : Payload required. VNC Password, Apple Remote Assistance, MOTD banner, SSH Daemon.
#+ chris.gerke@gmail.com

ME=$0
RES="$1/Contents/Resources"
ROOT="$3"
AGENT="AppleSharing"
DAEMON="AppleSharingSSH"

MOTD=$(sudo defaults read "${RES}/config" MOTD)
VNCPASSWD=$(sudo defaults read "${RES}/config" VNCPASSWD)

#+ // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

#+ MOTD Banner
sudo echo " " > "${ROOT}/etc/motd"
sudo echo "${MOTD}" >> "${ROOT}/etc/motd"
sudo echo " " >> "${ROOT}/etc/motd"

#+ VNC Password
sudo echo "${VNCPASSWD}" > "${ROOT}/Library/Preferences/com.apple.VNCSettings.txt"

#+ VNC Permissions
sudo chown -R root:wheel "${ROOT}/Library/Preferences/com.apple.VNCSettings.txt"
sudo chmod -R 600 "${ROOT}/Library/Preferences/com.apple.VNCSettings.txt"

#+ Admin check
sudo cat > "${ROOT}/usr/local/bin/ard" << EOPROFILE
#!/bin/sh
#* ard : Enable sharing for admins, configure sharing for end users.

#+ Enable Remote Management automatically for admins otherwise configure it so end users have to accept a connection
/usr/bin/dsmemberutil checkmembership -U "\${USER}" -G admin | /usr/bin/grep "not"
if [ "\$?" == "0" ]; then
 /usr/local/bin/ardoff
else
 /usr/local/bin/ardon
fi

exit 0
EOPROFILE

#+ Permissions
sudo chown root:wheel "${ROOT}/usr/local/bin/ard"
sudo chmod 755 "${ROOT}/usr/local/bin/ard"
sudo chmod u+s "${ROOT}/usr/local/bin/ard"

#* Detect payload & copy
if [ -r "${RES}/PAYLOAD" ]; then
 #+ Target
 sudo mkdir -p "${ROOT}/usr/local/bin"
 #+ Payload
 sudo cp -Rf "${RES}/PAYLOAD/" "${ROOT}/usr/local/bin"
 #+ Permissions
 sudo chown root:wheel "${ROOT}/usr/local/bin/ardoff"
 sudo chmod u+s "${ROOT}/usr/local/bin/ardoff"
 sudo chown root:wheel "${ROOT}/usr/local/bin/ardon"
 sudo chmod u+s "${ROOT}/usr/local/bin/ardon"
 sudo chown root:wheel "${ROOT}/usr/local/bin/sshon"
 sudo chmod u+s "${ROOT}/usr/local/bin/sshon"
fi

#+ LaunchAgent
sudo defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" Label "com.cmg.${DAEMON}"
sudo defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" RunAtLoad -bool TRUE
sudo defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/ard"

#+ Permissions
sudo /usr/sbin/chown root:wheel "${ROOT}/Library/LaunchAgents/${AGENT}.plist"
sudo /bin/chmod 644 "${ROOT}/Library/LaunchAgents/${AGENT}.plist"

#+ Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then sudo launchctl load -w "${ROOT}/Library/LaunchAgents/${AGENT}.plist"; fi

#+ LaunchDaemon
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" Label "com.cmg.${DAEMON}"
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" RunAtLoad -bool TRUE
sudo defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" ProgramArguments -array "/usr/sbin/systemsetup" "-setremotelogin" "on"

#+ Permissions
sudo chown root:wheel "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"
sudo chmod 644 "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"

#+ Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then sudo launchctl load -w "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"; fi

exit 0
