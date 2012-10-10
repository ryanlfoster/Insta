#!/bin/sh
# AppleSharing : Payload required. MOTD banner.
# chris.gerke@gmail.com

CONFIG=$(sudo defaults read "$1/Contents/Resources/config" MOTD)

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# MOTD Banner
sudo echo " " > "${ROOT}/etc/motd"
sudo echo "${CONFIG}" >> "${ROOT}/etc/motd"
sudo echo " " >> "${ROOT}/etc/motd"

exit 0
