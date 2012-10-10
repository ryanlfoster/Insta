#!/bin/sh
# AppleUserTemplate : Payload required. Default Apple User Template preferences.
# chris.gerke@gmail.com

HOMEPAGE="http://intranet"

# // fix
ROOT="$3"; if [ -z "${ROOT}" ] || [ "${ROOT}" = "/" ]; then ROOT=""; fi

# Multi OS
TARGET_OS=$(sudo defaults read "${ROOT}/System/Library/CoreServices/SystemVersion" ProductVersion)

# User Template
for USER_TEMPLATE in `sudo ls ${ROOT}/System/Library/User\ Template`
do
 if [ -r "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences" ]; then
  # com.apple.airplay.plist
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.airplay.dock" showInMenuBarIfPresent -bool NO
  # com.apple.dock.plist (basic settings only).
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.dock" autohide -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.dock" launchanim -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.dock" mineffect -string "scale"
  # com.apple.driver.AppleBluetoothMultitouch.trackpad
  # (snow leopard)
  sudo defaults write /Library/Preferences/.GlobalPreferences com.apple.mouse.tapBehavior -int 1
  # (multi touch snow leopard & lion done via ByHost)
  #sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.driver.AppleBluetoothMultitouch.trackpad" Clicking -bool YES
  # com.apple.ATS.plist
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.ATS" ATSAutoActivation -string ATSAutoActivationDisable
  # com.apple.Console.plist
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Console" ApplePersistenceIgnoreState YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Console" NSQuitAlwaysKeepsWindows -int 0
  # com.apple.CrashReporter.plist (hide from scared end users. maybe switch to basic mode...offers them the choice to delete prefs after second crash).
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.CrashReporter" DialogType Server
  # com.apple.desktopservices.plist (not doing this anymore. Causes weird behaviour with Windows Shares in pre 10.7).
  #sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.desktopservices" DSDontWriteNetworkStores -bool TRUE
  # com.apple.DiskUtility.plist
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.DiskUtility" advanced-image-options -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.DiskUtility" DUDebugMenuEnabled -bool YES
  # com.apple.finder.plist (possibly redundant if DisableAllAnimations is TRUE, requires testing).
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" AnimateInfoPanes -bool false
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" AnimateWindowZoom -bool false
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" ZoomRects -bool false
  # Squeeze some more juice out of older macs? requires testing.
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" DisableAllAnimations -bool true
  # More informative Finder window
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" _FXShowPosixPathInTitle -bool YES
  # A little faster when opening Finder
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" FXDefaultSearchScope -string SCcf
  # Speed up finder info on remote volumes
  sudo /usr/libexec/PlistBuddy -c "Add :FXInfoPanesExpanded dict" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Add :FXInfoPanesExpanded:Comments bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Set :FXInfoPanesExpanded:Comments NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Add :FXInfoPanesExpanded:General bool YES" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Set :FXInfoPanesExpanded:General YES" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Add :FXInfoPanesExpanded:MetaData bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Set :FXInfoPanesExpanded:MetaData NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Add :FXInfoPanesExpanded:Name bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Set :FXInfoPanesExpanded:Name NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Add :FXInfoPanesExpanded:Preview bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Set :FXInfoPanesExpanded:Preview NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Add :FXInfoPanesExpanded:Privileges bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  sudo /usr/libexec/PlistBuddy -c "Set :FXInfoPanesExpanded:Privileges NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder.plist
  # Just some standardisation
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" FXPreferredViewStyle -string Nlsv
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" NewWindowTarget -string PfHm
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" QLEnableTextSelection -bool TRUE
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" ShowHardDrivesOnDesktop -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" ShowMountedServersOnDesktop -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" ShowRemovableMediaOnDesktop -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" ShowPathbar -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.finder" ShowStatusBar -bool YES
  # com.apple.FontBook.plist
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.FontBook" FBValidateFontsBeforeInstalling -bool NO 
  # com.apple.iTunes.plist
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disableCheckForUpdates -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disableGeniusSidebar -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disableGetAlbumArtwork -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disablePing -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disablePingSidebar -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disablePodcasts -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disableRadio -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" disableSharedMusic -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" dontAutomaticallySyncIPods -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.iTunes" lookForSharedMusic -bool NO
  # com.apple.NetworkBrowser.plist
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.NetworkBrowser" DisableAirDrop -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.NetworkBrowser" BrowseAllInterfaces -bool NO
  # com.apple.print.PrintingPrefs
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.print.PrintingPrefs" "Quit When Finished" -bool true
  # com.apple.Safari.plist
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" ApplePersistenceIgnoreState YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" AutoFillFromAddressBook -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" AutoFillMiscellaneousForms -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" AutoFillPasswords -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" DomainsToNeverSetUp -array "aol.com" "facebook.com" "flickr.com" "google.com" "twitter.com" "vimeo.com" "yahoo.com"
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" IncludeDebugMenu 1
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" LastDisplayedWelcomePageVersionString -string 4.0
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" NewWindowBehaviour 0
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" NSQuitAlwaysKeepsWindows -int 0
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" RestoreSessionAtLaunch -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" WebKitJavaScriptCanOpenWindowsAutomatically -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" ShowStatusBar -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.Safari" HomePage "${HOMEPAGE}"
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.internetconfigpriv" WWWHomePage "${HOMEPAGE}"
  # com.apple.SetupAssistant.plist
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.SetupAssistant" DidSeeCloudSetup -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.SetupAssistant" GestureMovieSeen none
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.SetupAssistant" LastSeenCloudProductVersion "10.8"
  # com.apple.systempreferences.plist
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.systempreferences" HiddenPreferencePanes -array "com.apple.preference.notifications" "com.apple.preference.startupdisk" "com.apple.prefs.backup" "com.apple.preferences.softwareupdate" "com.apple.preferences.parentalcontrols" "com.apple.preference.internet" "com.apple.preferences.internetaccounts" "com.apple.preferences.icloud" "com.apple.preferences.sharing" "com.apple.preference.desktopscreeneffect" "com.apple.preference.security" "com.apple.preference.engerysaver" "com.NT-Ware.UniFLOWMacClientConfig"
  # com.apple.symbolichotkeys.plist (Disable Dashboard and Mission Control Keys so they are default Fn keys), arrggg! changes every time the OS adds functionality or new keys. Find and disable 10.8 dictation key.
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:32:enabled bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:32:enabled NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:33:enabled bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:33:enabled NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:34:enabled bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:34:enabled NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:35:enabled bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:35:enabled NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:36:enabled bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:36:enabled NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:37:enabled bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:37:enabled NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:52:enabled bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:52:enabled NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:59:enabled bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:59:enabled NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:62:enabled bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:62:enabled NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:63:enabled bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:63:enabled NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:64:enabled bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:64:enabled NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:65:enabled bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:65:enabled NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Add :AppleSymbolicHotKeys:73:enabled bool NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  sudo /usr/libexec/PlistBuddy -c "Set :AppleSymbolicHotKeys:73:enabled NO" ${ROOT}/System/Library/User\ Template/${USER_TEMPLATE}/Library/Preferences/com.apple.symbolichotkeys.plist
  # com.apple.TimeMachine.plist
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.TimeMachine" DoNotOfferNewDisksForBackup -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.TimeMachine" AutoBackup -bool NO
  # com.apple.universalaccess.plist
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.universalaccess" voiceOverOnOffKey -bool NO
  # .GlobalPreferences
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" AppleKeyboardUIMode -int 2
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" AppleMiniaturizeOnDoubleClick -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" AppleShowAllExtensions -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" AppleShowScrollBars -string "Always" 
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" NSAutomaticSpellingCorrectionEnabled -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" NSAutomaticWindowAnimationsEnabled -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" NSDocumentSaveNewDocumentsToCloud -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" NSNavPanelExpandedStateForSaveMode -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" NSQuitAlwaysKeepsWindows -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" PMPrintingExpandedStateForPrint -bool YES
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" com.apple.swipescrolldirection -bool NO
  sudo defaults write "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/.GlobalPreferences" com.apple.keyboard.fnState -bool YES
  
# Start ugly. I will work on making it nicer when I have time.
sudo cat > "${ROOT}/System/Library/User Template/${USER_TEMPLATE}/Library/Preferences/com.apple.sidebarlists.plist" << EOPROFILE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>favorites</key>
	<dict>
		<key>Controller</key>
		<string>VolumesList</string>
		<key>CustomListProperties</key>
		<dict>
			<key>com.apple.LSSharedFileList.Restricted.upgraded</key>
			<true/>
			<key>com.apple.LSSharedFileList.VolumesListMigrated</key>
			<true/>
		</dict>
		<key>ShowEjectables</key>
		<true/>
		<key>ShowHardDisks</key>
		<true/>
		<key>ShowRemovable</key>
		<true/>
		<key>ShowServers</key>
		<true/>
		<key>VolumesList</key>
		<array>
			<dict>
				<key>EntryType</key>
				<integer>16</integer>
				<key>Name</key>
				<string>iDisk</string>
				<key>SpecialID</key>
				<integer>1766093675</integer>
				<key>Visibility</key>
				<string>NeverVisible</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAAB2AAMAAQAAyk1lwwAASCsAAAAAAAAAAgABB1gA
				AMoisLgAAAAACSD//gAAAAAAAAAA/////wABAAAADgAQ
				AAcATgBlAHQAdwBvAHIAawAPAAoABABPAFMAWABMABIA
				B05ldHdvcmsAABMAAS8A//8AAA==
				</data>
				<key>EntryType</key>
				<integer>16</integer>
				<key>Name</key>
				<string>Network</string>
				<key>SpecialID</key>
				<integer>1735288180</integer>
				<key>Visibility</key>
				<string>NeverVisible</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAACEAAMAAQAAyk1lwwAASCsAAAAAAAAAAgAAAKUA
				AMoBn94AAAAACSD//gAAAAAAAAAA/////wABAAAADgAa
				AAwAQQBwAHAAbABpAGMAYQB0AGkAbwBuAHMADwAKAAQA
				TwBTAFgATAASAAxBcHBsaWNhdGlvbnMAEwABLwD//wAA
				</data>
				<key>CustomItemProperties</key>
				<dict>
					<key>com.apple.LSSharedFileList.TemplateSystemSelector</key>
					<integer>1935819120</integer>
				</dict>
				<key>Icon</key>
				<data>
				SW1nUgAAASIAAAAARkJJTAAAARYAAAACAAAAAAAAAAAB
				BgADAAAAAMpNZcMAAEgrAAAAAAAACycAADnYAADKKdM8
				AAAAAAkg//4AAAAAAAAAAP////8AAQAYAAALJwAACTkA
				AAk4AAAAhgAAAHkAAAB4AA4ANgAaAFQAbwBvAGwAYgBh
				AHIAQQBwAHAAcwBGAG8AbABkAGUAcgBJAGMAbwBuAC4A
				aQBjAG4AcwAPAAoABABPAFMAWABMABIAWlN5c3RlbS9M
				aWJyYXJ5L0NvcmVTZXJ2aWNlcy9Db3JlVHlwZXMuYnVu
				ZGxlL0NvbnRlbnRzL1Jlc291cmNlcy9Ub29sYmFyQXBw
				c0ZvbGRlckljb24uaWNucwATAAEvAP//AAA=
				</data>
				<key>Name</key>
				<string>Applications</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAACYAAMAAQAAyk1lwwAASCsAAAAAAAStUAAErVIA
				AMpOkJUAAAAACSD//gAAAAAAAAAA/////wABAAwABK1Q
				AAAAaAAAAGQADgAQAAcARABlAHMAawB0AG8AcAAPAAoA
				BABPAFMAWABMABIAF3ByaXZhdGUvdmFyL2FyZC9EZXNr
				dG9wAAATAAEvAAAVAAIAEP//AAA=
				</data>
				<key>CustomItemProperties</key>
				<dict>
					<key>com.apple.LSSharedFileList.TemplateSystemSelector</key>
					<integer>1935819892</integer>
				</dict>
				<key>Icon</key>
				<data>
				SW1nUgAAASwAAAAARkJJTAAAASAAAAACAAAAAAAAAAAB
				EAADAAAAAMpNZcMAAEgrAAAAAAAACycAADnbAADKKdM8
				AAAAAAkg//4AAAAAAAAAAP////8AAQAYAAALJwAACTkA
				AAk4AAAAhgAAAHkAAAB4AA4APAAdAFQAbwBvAGwAYgBh
				AHIARABlAHMAawB0AG8AcABGAG8AbABkAGUAcgBJAGMA
				bwBuAC4AaQBjAG4AcwAPAAoABABPAFMAWABMABIAXVN5
				c3RlbS9MaWJyYXJ5L0NvcmVTZXJ2aWNlcy9Db3JlVHlw
				ZXMuYnVuZGxlL0NvbnRlbnRzL1Jlc291cmNlcy9Ub29s
				YmFyRGVza3RvcEZvbGRlckljb24uaWNucwAAEwABLwD/
				/wAA
				</data>
				<key>Name</key>
				<string>Desktop</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAACeAAMAAQAAyk1lwwAASCsAAAAAAAStUAAEvfgA
				AMpOnyoAAAAACSD//gAAAAAAAAAA/////wABAAwABK1Q
				AAAAaAAAAGQADgAUAAkARABvAGMAdQBtAGUAbgB0AHMA
				DwAKAAQATwBTAFgATAASABlwcml2YXRlL3Zhci9hcmQv
				RG9jdW1lbnRzAAATAAEvAAAVAAIAEP//AAA=
				</data>
				<key>CustomItemProperties</key>
				<dict>
					<key>com.apple.LSSharedFileList.TemplateSystemSelector</key>
					<integer>1935819875</integer>
				</dict>
				<key>Icon</key>
				<data>
				SW1nUgAAATIAAAAARkJJTAAAASYAAAACAAAAAAAAAAAB
				FgADAAAAAMpNZcMAAEgrAAAAAAAACycAADncAADKKdM8
				AAAAAAkg//4AAAAAAAAAAP////8AAQAYAAALJwAACTkA
				AAk4AAAAhgAAAHkAAAB4AA4AQAAfAFQAbwBvAGwAYgBh
				AHIARABvAGMAdQBtAGUAbgB0AHMARgBvAGwAZABlAHIA
				SQBjAG8AbgAuAGkAYwBuAHMADwAKAAQATwBTAFgATAAS
				AF9TeXN0ZW0vTGlicmFyeS9Db3JlU2VydmljZXMvQ29y
				ZVR5cGVzLmJ1bmRsZS9Db250ZW50cy9SZXNvdXJjZXMv
				VG9vbGJhckRvY3VtZW50c0ZvbGRlckljb24uaWNucwAA
				EwABLwD//wAA
				</data>
				<key>Name</key>
				<string>Documents</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAACeAAMAAQAAyk1lwwAASCsAAAAAAAStUAAEvc4A
				AMpOnyoAAAAACSD//gAAAAAAAAAA/////wABAAwABK1Q
				AAAAaAAAAGQADgAUAAkARABvAHcAbgBsAG8AYQBkAHMA
				DwAKAAQATwBTAFgATAASABlwcml2YXRlL3Zhci9hcmQv
				RG93bmxvYWRzAAATAAEvAAAVAAIAEP//AAA=
				</data>
				<key>CustomItemProperties</key>
				<dict>
					<key>com.apple.LSSharedFileList.TemplateSystemSelector</key>
					<integer>1935819884</integer>
				</dict>
				<key>Icon</key>
				<data>
				SW1nUgAAABwAAAAAU1lTTAAAABAAAAAAdER3bg==
				</data>
				<key>Name</key>
				<string>Downloads</string>
			</dict>
		</array>
	</dict>
	<key>networkbrowser</key>
	<dict>
		<key>Controller</key>
		<string>CustomListItems</string>
		<key>CustomListItems</key>
		<array/>
		<key>CustomListProperties</key>
		<dict>
			<key>com.apple.NetworkBrowser.backToMyMacEnabled</key>
			<false/>
			<key>com.apple.NetworkBrowser.bonjourEnabled</key>
			<false/>
		</dict>
	</dict>
	<key>savedsearches</key>
	<dict>
		<key>Controller</key>
		<string>CustomListItems</string>
		<key>CustomListItems</key>
		<array>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAAD8AAMAAQAAyk1lwwAASCsAAAAAAAC5ywAAuhQA
				AMoorHUAAAAACSD//gAAAAAAAAAA/////wABABwAALnL
				AAC5vwAAuboAALm5AAAAhgAAAHkAAAB4AA4AJgASAFQA
				bwBkAGEAeQAuAGMAYQBuAG4AZQBkAFMAZQBhAHIAYwBo
				AA8ACgAEAE8AUwBYAEwAEgBbU3lzdGVtL0xpYnJhcnkv
				Q29yZVNlcnZpY2VzL0ZpbmRlci5hcHAvQ29udGVudHMv
				UmVzb3VyY2VzL0Nhbm5lZFNlYXJjaGVzL1RvZGF5LmNh
				bm5lZFNlYXJjaAAAEwABLwD//wAA
				</data>
				<key>Icon</key>
				<data>
				SW1nUgAAASQAAAAARkJJTAAAARgAAAACAAAAAAAAAAAB
				CAADAAAAAMpNZcMAAEgrAAAAAAAAuhUAALoZAADKKKx1
				AAAAAAkg//4AAAAAAAAAAP////8AAQAkAAC6FQAAuhQA
				ALnLAAC5vwAAuboAALm5AAAAhgAAAHkAAAB4AA4AFgAK
				AFQAbwBkAGEAeQAuAGkAYwBuAHMADwAKAAQATwBTAFgA
				TAASAHBTeXN0ZW0vTGlicmFyeS9Db3JlU2VydmljZXMv
				RmluZGVyLmFwcC9Db250ZW50cy9SZXNvdXJjZXMvQ2Fu
				bmVkU2VhcmNoZXMvVG9kYXkuY2FubmVkU2VhcmNoL1Jl
				c291cmNlcy9Ub2RheS5pY25zABMAAS8A//8AAA==
				</data>
				<key>Name</key>
				<string>Today</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAAEIAAMAAQAAyk1lwwAASCsAAAAAAAC5ywAAuhwA
				AMoorHUAAAAACSD//gAAAAAAAAAA/////wABABwAALnL
				AAC5vwAAuboAALm5AAAAhgAAAHkAAAB4AA4ALgAWAFkA
				ZQBzAHQAZQByAGQAYQB5AC4AYwBhAG4AbgBlAGQAUwBl
				AGEAcgBjAGgADwAKAAQATwBTAFgATAASAF9TeXN0ZW0v
				TGlicmFyeS9Db3JlU2VydmljZXMvRmluZGVyLmFwcC9D
				b250ZW50cy9SZXNvdXJjZXMvQ2FubmVkU2VhcmNoZXMv
				WWVzdGVyZGF5LmNhbm5lZFNlYXJjaAAAEwABLwD//wAA
				</data>
				<key>Icon</key>
				<data>
				SW1nUgAAATQAAAAARkJJTAAAASgAAAACAAAAAAAAAAAB
				GAADAAAAAMpNZcMAAEgrAAAAAAAAuh0AALohAADKKKx1
				AAAAAAkg//4AAAAAAAAAAP////8AAQAkAAC6HQAAuhwA
				ALnLAAC5vwAAuboAALm5AAAAhgAAAHkAAAB4AA4AHgAO
				AFkAZQBzAHQAZQByAGQAYQB5AC4AaQBjAG4AcwAPAAoA
				BABPAFMAWABMABIAeFN5c3RlbS9MaWJyYXJ5L0NvcmVT
				ZXJ2aWNlcy9GaW5kZXIuYXBwL0NvbnRlbnRzL1Jlc291
				cmNlcy9DYW5uZWRTZWFyY2hlcy9ZZXN0ZXJkYXkuY2Fu
				bmVkU2VhcmNoL1Jlc291cmNlcy9ZZXN0ZXJkYXkuaWNu
				cwATAAEvAP//AAA=
				</data>
				<key>Name</key>
				<string>Yesterday</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAAEIAAMAAQAAyk1lwwAASCsAAAAAAAC5ywAAugwA
				AMoorHUAAAAACSD//gAAAAAAAAAA/////wABABwAALnL
				AAC5vwAAuboAALm5AAAAhgAAAHkAAAB4AA4ALgAWAFAA
				YQBzAHQAIABXAGUAZQBrAC4AYwBhAG4AbgBlAGQAUwBl
				AGEAcgBjAGgADwAKAAQATwBTAFgATAASAF9TeXN0ZW0v
				TGlicmFyeS9Db3JlU2VydmljZXMvRmluZGVyLmFwcC9D
				b250ZW50cy9SZXNvdXJjZXMvQ2FubmVkU2VhcmNoZXMv
				UGFzdCBXZWVrLmNhbm5lZFNlYXJjaAAAEwABLwD//wAA
				</data>
				<key>Icon</key>
				<data>
				SW1nUgAAATIAAAAARkJJTAAAASYAAAACAAAAAAAAAAAB
				FgADAAAAAMpNZcMAAEgrAAAAAAAAug0AALoRAADKKKx1
				AAAAAAkg//4AAAAAAAAAAP////8AAQAkAAC6DQAAugwA
				ALnLAAC5vwAAuboAALm5AAAAhgAAAHkAAAB4AA4AHAAN
				AFQAaABpAHMAVwBlAGUAawAuAGkAYwBuAHMADwAKAAQA
				TwBTAFgATAASAHdTeXN0ZW0vTGlicmFyeS9Db3JlU2Vy
				dmljZXMvRmluZGVyLmFwcC9Db250ZW50cy9SZXNvdXJj
				ZXMvQ2FubmVkU2VhcmNoZXMvUGFzdCBXZWVrLmNhbm5l
				ZFNlYXJjaC9SZXNvdXJjZXMvVGhpc1dlZWsuaWNucwAA
				EwABLwD//wAA
				</data>
				<key>Name</key>
				<string>Past Week</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAAEUAAMAAQAAyk1lwwAASCsAAAAAAAC5ywAAudQA
				AMoorHUAAAAACSD//gAAAAAAAAAA/////wABABwAALnL
				AAC5vwAAuboAALm5AAAAhgAAAHkAAAB4AA4ANgAaAEEA
				bABsACAARABvAGMAdQBtAGUAbgB0AHMALgBjAGEAbgBu
				AGUAZABTAGUAYQByAGMAaAAPAAoABABPAFMAWABMABIA
				Y1N5c3RlbS9MaWJyYXJ5L0NvcmVTZXJ2aWNlcy9GaW5k
				ZXIuYXBwL0NvbnRlbnRzL1Jlc291cmNlcy9DYW5uZWRT
				ZWFyY2hlcy9BbGwgRG9jdW1lbnRzLmNhbm5lZFNlYXJj
				aAAAEwABLwD//wAA
				</data>
				<key>Icon</key>
				<data>
				SW1nUgAAAP4AAAAARkJJTAAAAPIAAAACAAAAAAAAAAAA
				4gADAAAAAMpNZcMAAEgrAAAAAAAAub8AALqVAADKKKxs
				AAAAAAkg//4AAAAAAAAAAP////8AAQAYAAC5vwAAuboA
				ALm5AAAAhgAAAHkAAAB4AA4AIgAQAFMAbQBhAHIAdABG
				AG8AbABkAGUAcgAuAGkAYwBuAHMADwAKAAQATwBTAFgA
				TAASAEpTeXN0ZW0vTGlicmFyeS9Db3JlU2VydmljZXMv
				RmluZGVyLmFwcC9Db250ZW50cy9SZXNvdXJjZXMvU21h
				cnRGb2xkZXIuaWNucwATAAEvAP//AAA=
				</data>
				<key>Name</key>
				<string>All Documents</string>
			</dict>
		</array>
	</dict>
	<key>systemitems</key>
	<dict>
		<key>Controller</key>
		<string>VolumesList</string>
		<key>CustomListProperties</key>
		<dict>
			<key>com.apple.LSSharedFileList.VolumesListMigrated</key>
			<true/>
		</dict>
		<key>ShowEjectables</key>
		<true/>
		<key>ShowHardDisks</key>
		<true/>
		<key>ShowRemovable</key>
		<true/>
		<key>ShowServers</key>
		<true/>
		<key>VolumesList</key>
		<array>
			<dict>
				<key>EntryType</key>
				<integer>16</integer>
				<key>Flags</key>
				<integer>1</integer>
				<key>Name</key>
				<string>Computer</string>
				<key>SpecialID</key>
				<integer>1919905652</integer>
				<key>Visibility</key>
				<string>AlwaysVisible</string>
			</dict>
			<dict>
				<key>EntryType</key>
				<integer>16</integer>
				<key>Name</key>
				<string>iDisk</string>
				<key>SpecialID</key>
				<integer>1766093675</integer>
				<key>Visibility</key>
				<string>NeverVisible</string>
			</dict>
			<dict>
				<key>Alias</key>
				<data>
				AAAAAAB2AAMAAQAAyk1lwwAASCsAAAAAAAAAAgABB1gA
				AMoisLgAAAAACSD//gAAAAAAAAAA/////wABAAAADgAQ
				AAcATgBlAHQAdwBvAHIAawAPAAoABABPAFMAWABMABIA
				B05ldHdvcmsAABMAAS8A//8AAA==
				</data>
				<key>EntryType</key>
				<integer>16</integer>
				<key>Name</key>
				<string>Network</string>
				<key>SpecialID</key>
				<integer>1735288180</integer>
				<key>Visibility</key>
				<string>NeverVisible</string>
			</dict>
		</array>
	</dict>
</dict>
</plist>
EOPROFILE
# End ugly

 fi
done

exit 0