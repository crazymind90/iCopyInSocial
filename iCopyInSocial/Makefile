ARCHS = arm64e arm64 armv7 armv7s

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = iCopyInSocial

iCopyInSocial_FILES = iCopyInSocialController.m
iCopyInSocial_INSTALL_PATH = /Library/PreferenceBundles
iCopyInSocial_FRAMEWORKS = UIKit
iCopyInSocial_PRIVATE_FRAMEWORKS = Preferences
iCopyInSocial_EXTRA_FRAMEWORKS = Cephei CepheiPrefs
iCopyInSocial_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/iCopyInSocial.plist$(ECHO_END)
