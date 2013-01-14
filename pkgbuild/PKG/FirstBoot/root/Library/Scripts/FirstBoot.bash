#!/bin/bash
# chris.gerke@gmail.com

WORKING_DIR=$(dirname "${0}")

# Execute SH
for i in `ls "${WORKING_DIR}/" | grep ".sh"`
do
 sudo "${WORKING_DIR}/${i}"
done

# Install PKGs
for i in `ls ${WORKING_DIR}/ | grep ".pkg"`
do
 sudo installer -pkg "${WORKING_DIR}/${i}" -target /
done

# Install MPKGs
for i in `ls ${WORKING_DIR}/ | grep ".mpkg"`
do
 sudo installer -pkg "${WORKING_DIR}/${i}" -target /
done

# Self destruct?
sudo srm "$0"