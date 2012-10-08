#!/bin/sh
# AppleSharing : Payload required. VNC Password, Apple Remote Assistance, MOTD banner, SSH Daemon.
# chris.gerke@gmail.com

ME=$0
RES="$1/Contents/Resources"
ROOT="$3"
AGENT="AppleSharing"
DAEMON="AppleSharingSSH"

MOTD=$(sudo /usr/bin/defaults read "${RES}/config" MOTD)
VNCPASSWD=$(sudo /usr/bin/defaults read "${RES}/config" VNCPASSWD)

# // fix
if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# MOTD Banner
sudo /bin/echo " " > "${ROOT}/etc/motd"
sudo /bin/echo "${MOTD}" >> "${ROOT}/etc/motd"
sudo /bin/echo " " >> "${ROOT}/etc/motd"

# VNC Password
sudo /bin/echo "${VNCPASSWD}" > "${ROOT}/Library/Preferences/com.apple.VNCSettings.txt"

# VNC Permissions
sudo /usr/sbin/chown -R root:wheel "${ROOT}/Library/Preferences/com.apple.VNCSettings.txt"
sudo /bin/chmod -R 600 "${ROOT}/Library/Preferences/com.apple.VNCSettings.txt"

# Admin check
sudo /bin/cat > "${ROOT}/usr/local/bin/ard" << EOPROFILE
#!/bin/sh
# ard
# chris.gerke@gmail.com
#
# Description: Enable sharing for admins, configure sharing for end users.
#
# Version: 1.0
#
# History:
#     1.0: Script.
#
# TODO:
#     * Add error checking?

# Enable Remote Management automatically for admins otherwise configure it so end users have to accept a connection
/usr/bin/dsmemberutil checkmembership -U "\${USER}" -G admin | /usr/bin/grep "not"
if [ "\$?" == "0" ]; then
 /usr/local/bin/ardoff
else
 /usr/local/bin/ardon
fi

exit 0
EOPROFILE
# Permissions
sudo /usr/sbin/chown root:wheel "${ROOT}/usr/local/bin/ard"
sudo /bin/chmod 755 "${ROOT}/usr/local/bin/ard"
sudo /bin/chmod u+s "${ROOT}/usr/local/bin/ard"

# Payload
if [ -r "${RES}/PAYLOAD" ]; then
 # Target
 sudo /bin/mkdir -p "${ROOT}/usr/local/bin"
 # Payload
 sudo /bin/cp -Rf "${RES}/PAYLOAD/" "${ROOT}/usr/local/bin"
 # Permissions
 sudo /usr/sbin/chown root:wheel "${ROOT}/usr/local/bin/ardoff"
 sudo /bin/chmod u+s "${ROOT}/usr/local/bin/ardoff"
 # Permissions
 sudo /usr/sbin/chown root:wheel "${ROOT}/usr/local/bin/ardon"
 sudo /bin/chmod u+s "${ROOT}/usr/local/bin/ardon"
 # Permissions
 sudo /usr/sbin/chown root:wheel "${ROOT}/usr/local/bin/sshon"
 sudo /bin/chmod u+s "${ROOT}/usr/local/bin/sshon"
fi

# LaunchAgent
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" Label "com.cg.${AGENT}"
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/ard"

# Permissions
sudo /usr/sbin/chown root:wheel "${ROOT}/Library/LaunchAgents/${AGENT}.plist"
sudo /bin/chmod 644 "${ROOT}/Library/LaunchAgents/${AGENT}.plist"

# Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then
 sudo /bin/launchctl load -w "${ROOT}/Library/LaunchAgents/${AGENT}.plist"
fi

# LaunchDaemon
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" Label "com.cg.${DAEMON}"
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" RunAtLoad -bool TRUE
sudo /usr/bin/defaults write "${ROOT}/Library/LaunchDaemons/${DAEMON}" ProgramArguments -array "/usr/sbin/systemsetup" "-setremotelogin" "on"

# Permissions
sudo /usr/sbin/chown root:wheel "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"
sudo /bin/chmod 644 "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"

# Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then
 sudo /bin/launchctl load -w "${ROOT}/Library/LaunchDaemons/${DAEMON}.plist"
fi

exit 0
