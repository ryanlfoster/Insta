#!/bin/bash
# chris.gerke@gmail.com
# Simple loop to create flat packages for every folder in WORKING_DIR containing scripts.

ORG="cmg"
WORKING_DIR=$(dirname "${0}")
VERSION=$(date +"%Y%m%d%H%M%S")

mkdir -p "${WORKING_DIR}/PKG"
mkdir -p "${WORKING_DIR}/PKG/_Deploy"

for PKG in `ls ${WORKING_DIR}/PKG | grep -v _Deploy | grep -v .pkg`
do

 if [ -a "${WORKING_DIR}/PKG/_Deploy/${PKG}.pkg" ]; then
 
  echo " "
  echo "***				skipping ${PKG}.pkg";
  echo " "
 
 else
  
  [ -e "${WORKING_DIR}/PKG/${PKG}/scripts/postinstall" ] && chmod a+x "${WORKING_DIR}/PKG/${PKG}/scripts/postinstall"

  if [ -e "${WORKING_DIR}/PKG/${PKG}/root" ]; then
   pkgbuild --identifier com.${ORG}.${PKG} --root "${WORKING_DIR}/PKG/${PKG}/root" --scripts "${WORKING_DIR}/PKG/${PKG}/scripts" --version "${VERSION}" "${WORKING_DIR}/PKG/_Deploy/${PKG}.pkg"
  else
   pkgbuild --identifier com.${ORG}.${PKG} --nopayload --scripts "${WORKING_DIR}/PKG/${PKG}/scripts" --version "${VERSION}" "${WORKING_DIR}/PKG/_Deploy/${PKG}.pkg"
  fi

 fi

done

exit 0