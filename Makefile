TARGET = iphone:clang:13.0:13.0

ARCHS = arm64 arm64e

DEBUG = 0

FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BlurSwitch
BlurSwitch_FILES = Tweak.xm
BlurSwitch_EXTRA_FRAMEWORKS += Cephei
BlurSwitch_FRAMEWORKS = UIKit
BlurSwitch_LIBRARIES += sparkcolourpicker
BlurSwitch_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "sbreload"
SUBPROJECTS += blurswitchprefs
include $(THEOS_MAKE_PATH)/aggregate.mk