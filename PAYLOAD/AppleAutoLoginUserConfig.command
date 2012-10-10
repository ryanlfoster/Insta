#!/bin/bash
 
WORKING_DIR=$(/usr/bin/dirname "${0}")

echo "${0} ${WORKING_DIR}"

# user
echo "Set AutoLoginUser shortname?"
read AUTOLOGINUSER

# kcpassword
echo "kcpassword ready? attempting to copy."
sudo /bin/cp -f /etc/kcpassword "${WORKING_DIR}/PAYLOAD/kcpassword"
defaults write "${WORKING_DIR}/config" AUTOLOGINUSER "${AUTOLOGINUSER}"

exit 0