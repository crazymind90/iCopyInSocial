ARCHS = arm64e arm64 armv7 armv7s

THEOS_DEVICE_IP = 192.168.1.3

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = iCopyInSocial

iCopyInSocial_FILES = Tweak.xm
iCopyInSocial_CFLAGS = -fobjc-arc
iCopyInSocial_EXTRA_FRAMEWORKS += Cephei
iCopyInSocial_FRAMEWORKS = UIKit


include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += iCopyInSocial
include $(THEOS_MAKE_PATH)/aggregate.mk

install3::
		install3.exec
