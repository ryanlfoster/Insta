#!/bin/sh
# AppleSharing : Payload free. MOTD banner.
# chris.gerke@gmail.com

CONFIG="Unauthorized access to these resources is prohibited."

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# MOTD Banner
sudo echo " " > "${ROOT}/etc/motd"
sudo echo "${CONFIG}" >> "${ROOT}/etc/motd"
sudo echo " " >> "${ROOT}/etc/motd"

exit 0
