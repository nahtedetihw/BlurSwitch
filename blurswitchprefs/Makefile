ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = blurswitchprefs
blurswitchprefs_FILES = BLURSWITCHPreferences.m
blurswitchprefs_INSTALL_PATH = /Library/PreferenceBundles
blurswitchprefs_FRAMEWORKS = UIKit
blurswitchprefs_PRIVATE_FRAMEWORKS = Preferences
blurswitchprefs_EXTRA_FRAMEWORKS = Cephei CepheiPrefs
blurswitchprefs_LIBRARIES += sparkcolourpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/blurswitchprefs.plist$(ECHO_END)
