#!/bin/sh
# AppleSharing : Payload required. Apple Remote Assistance.
# chris.gerke@gmail.com

AGENT="AppleSharing"

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Admin check
sudo cat > "${ROOT}/usr/local/bin/ard" << EOPROFILE
#!/bin/sh
# ard : Enable sharing for admins, configure sharing for end users.

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
sudo chown root:wheel "${ROOT}/usr/local/bin/ard"
sudo chmod 755 "${ROOT}/usr/local/bin/ard"
sudo chmod u+s "${ROOT}/usr/local/bin/ard"

# Detect payload & copy
if [ -r "$1/Contents/Resources/PAYLOAD" ]; then
 # Target
 sudo mkdir -p "${ROOT}/usr/local/bin"
 # Payload
 sudo cp -Rf "$1/Contents/Resources/PAYLOAD/" "${ROOT}/usr/local/bin"
 # Permissions
 sudo chown root:wheel "${ROOT}/usr/local/bin/ardoff"
 sudo chmod u+s "${ROOT}/usr/local/bin/ardoff"
 sudo chown root:wheel "${ROOT}/usr/local/bin/ardon"
 sudo chmod u+s "${ROOT}/usr/local/bin/ardon"
 sudo chown root:wheel "${ROOT}/usr/local/bin/sshon"
 sudo chmod u+s "${ROOT}/usr/local/bin/sshon"
fi

# LaunchAgent
sudo defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" Label "com.cmg.${AGENT}"
sudo defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" RunAtLoad -bool TRUE
sudo defaults write "${ROOT}/Library/LaunchAgents/${AGENT}" ProgramArguments -array "/bin/sh" "-c" "/usr/local/bin/ard"

# Permissions
sudo /usr/sbin/chown root:wheel "${ROOT}/Library/LaunchAgents/${AGENT}.plist"
sudo /bin/chmod 644 "${ROOT}/Library/LaunchAgents/${AGENT}.plist"

# Load if booted
if [ -z "${ROOT}" ] || [ "${ROOT}" = "" ]; then sudo launchctl load -w "${ROOT}/Library/LaunchAgents/${AGENT}.plist"; fi

exit 0
