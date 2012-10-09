#!/bin/bash
# Package InstallerFiles

## InstallerFiles output directory
if [ "$1" == "" ]; then clear; echo "Usage : $0 OUTPUT_DIR"; exit; fi

WORKING_DIR=$(/usr/bin/dirname "${0}")
OUTPUT_DIR=$1
VERSION=$(date +"%Y%m%d%H%M%S")
echo "${VERSION}" > "${OUTPUT_DIR}/INSTA_OUTPUT/packagemaker.txt"

clear
mkdir -p "${OUTPUT_DIR}"
mkdir -p "${OUTPUT_DIR}/INSTA_OUTPUT"
echo "${0} searching ${WORKING_DIR}"

for PKG_POSTFLIGHT in `/usr/bin/find -L ${WORKING_DIR} -name "*.sh" | /usr/bin/grep -v "Payload"`
do
 PKGMKR="/Applications/PackageMaker.app/Contents/MacOS/PackageMaker"
 ROOT=$(/usr/bin/dirname "${PKG_POSTFLIGHT}")
 IDENTIFIER=$(/usr/bin/basename "${PKG_POSTFLIGHT}" | sed 's/.sh//g')
 DESCRIPTION=$(cat "${PKG_POSTFLIGHT}" | head -n 2 | tail -n 1 | sed "s/# //g")
 
 #echo "${0} Root: ${ROOT}"
 #echo "${0} Identifier: ${IDENTIFIER}"
 #echo "${0} ${DESCRIPTION}"
 #echo "${0} Version: ${VERSION}"
 
 if [ -a "${OUTPUT_DIR}/INSTA_OUTPUT/${IDENTIFIER}.pkg" ]; then
  echo "***				skipping ${IDENTIFIER}.pkg";
 else
  echo "${IDENTIFIER} build"
  mkdir -p "${OUTPUT_DIR}/INSTA_OUTPUT/INSTA_RESOURCES"
  mkdir -p "${OUTPUT_DIR}/INSTA_OUTPUT/INSTA_ROOT/Library"
  mkdir -p "${OUTPUT_DIR}/INSTA_OUTPUT/INSTA_SCRIPTS"
  #echo "	${IDENTIFIER} postflight"
  cp -f "${PKG_POSTFLIGHT}" "${OUTPUT_DIR}/INSTA_OUTPUT/INSTA_SCRIPTS/postflight"
  #echo "	${IDENTIFIER} package"
  ${PKGMKR} --id "com.cmg.${IDENTIFIER}" --title "${IDENTIFIER}" --version "${VERSION}" --resources "${OUTPUT_DIR}/INSTA_OUTPUT/INSTA_RESOURCES" --scripts "${OUTPUT_DIR}/INSTA_OUTPUT/INSTA_SCRIPTS" --root "${OUTPUT_DIR}/INSTA_OUTPUT/INSTA_ROOT" --out "${OUTPUT_DIR}/INSTA_OUTPUT/${IDENTIFIER}.pkg" --verbose >> "${OUTPUT_DIR}/INSTA_OUTPUT/packagemaker.txt"
  #echo "	${IDENTIFIER} version"
  defaults write "${OUTPUT_DIR}/INSTA_OUTPUT/${IDENTIFIER}.pkg/Contents/Resources/en.lproj/Description" IFPkgDescriptionDescription "${DESCRIPTION}"
  if [ -r "${ROOT}/${IDENTIFIER}Config.plist" ]; then
   echo "***	${IDENTIFIER} config.plist"
   cp -Rf "${ROOT}/${IDENTIFIER}Config.plist" "${OUTPUT_DIR}/INSTA_OUTPUT/${IDENTIFIER}.pkg/Contents/Resources/config.plist"
  fi
  if [ -r "${ROOT}/${IDENTIFIER}Config.bash" ]; then
   echo "***	${IDENTIFIER} config.bash"
   cp -Rf "${ROOT}/${IDENTIFIER}Config.bash" "${OUTPUT_DIR}/INSTA_OUTPUT/${IDENTIFIER}.pkg/Contents/Resources/config.bash"
   "${OUTPUT_DIR}/INSTA_OUTPUT/${IDENTIFIER}.pkg/Contents/Resources/config.bash"
  fi
  if [ -r "${ROOT}/${IDENTIFIER}Payload" ]; then
   echo "***	${IDENTIFIER} payload"
   cp -R "${ROOT}/${IDENTIFIER}Payload" "${OUTPUT_DIR}/INSTA_OUTPUT/${IDENTIFIER}.pkg/Contents/Resources/PAYLOAD"
  fi
  rm -Rf "${OUTPUT_DIR}/INSTA_OUTPUT/INSTA_RESOURCES"
  rm -Rf "${OUTPUT_DIR}/INSTA_OUTPUT/INSTA_ROOT"
  rm -Rf "${OUTPUT_DIR}/INSTA_OUTPUT/INSTA_SCRIPTS"
 fi

done

 #~/InstaDMG/Addons/InstaUp2Date/checksum.py ${OUTPUT_DIR}/INSTA_OUTPUT/*

exit 0