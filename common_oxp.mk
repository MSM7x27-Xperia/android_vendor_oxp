PRODUCT_BRAND ?= cyanogenmod

ifneq ($(TARGET_BOOTANIMATION_NAME),)
    PRODUCT_COPY_FILES += \
        vendor/cm/prebuilt/common/bootanimation/$(TARGET_BOOTANIMATION_NAME).zip:system/media/bootanimation.zip
endif

PRODUCT_PROPERTY_OVERRIDES += \
    ro.rommanager.developerid=cyanogenmod

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-sonyericsson \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

# Copy over the changelog to the device
PRODUCT_COPY_FILES += \
    vendor/cm/CHANGELOG.mkdn:system/etc/CHANGELOG-CM.txt

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/cm/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/cm/prebuilt/common/bin/50-cm.sh:system/addon.d/50-cm.sh

# init.d support
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/cm/prebuilt/common/bin/sysinit:system/bin/sysinit

# userinit support
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit

# Compcache/Zram support
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/init.local.rc:system/etc/init.local.rc \
    vendor/cm/prebuilt/common/bin/compcache:system/bin/compcache \
    vendor/cm/prebuilt/common/bin/handle_compcache:system/bin/handle_compcache

# Bring in camera effects
PRODUCT_COPY_FILES +=  \
    vendor/cm/prebuilt/common/media/LMprec_508.emd:system/media/LMprec_508.emd \
    vendor/cm/prebuilt/common/media/PFFprec_600.emd:system/media/PFFprec_600.emd

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/base/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# This is CM!
PRODUCT_COPY_FILES += \
    vendor/cm/config/permissions/com.cyanogenmod.android.xml:system/etc/permissions/com.cyanogenmod.android.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/cm/prebuilt/common/etc/mkshrc:system/etc/mkshrc

# Required CM packages
PRODUCT_PACKAGES += \
    Camera \
    LatinIME \
    Superuser \
    Superuser.apk \
    su

# Optional CM packages
PRODUCT_PACKAGES += \
    VideoEditor \
    VoiceDialer \
    SoundRecorder \
    Basic \
    HoloSpiralWallpaper \
    MagicSmokeWallpapers \
    NoiseField \
    Galaxy4 \
    LiveWallpapers \
    LiveWallpapersPicker \
    VisualizationWallpapers \
    PhaseBeam

# OXP
PRODUCT_PACKAGES += libFLAC

PRODUCT_COPY_FILES += \
    vendor/oxp/prebuilt/app/FileManager.apk:system/app/FileManager.apk \
    vendor/oxp/prebuilt/app/Music.apk:system/app/Music.apk \
    vendor/oxp/prebuilt/app/SRSPanel.apk:system/app/SRSPanel.apk \
    vendor/oxp/prebuilt/app/Term.apk:system/app/Term.apk \
    vendor/oxp/prebuilt/etc/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    vendor/oxp/prebuilt/etc/SRSAudioFilter.csv:system/etc/SRSAudioFilter.csv \
    vendor/oxp/prebuilt/lib/soundfx/libsrsfx.so:system/lib/soundfx/libsrsfx.so \
    vendor/oxp/prebuilt/lib/soundfx/libsrstb.so:system/lib/soundfx/libsrstb.so \
    vendor/oxp/prebuilt/lib/libjackpal-androidterm3.so:system/lib/libjackpal-androidterm3.so

# Custom CM packages
PRODUCT_PACKAGES += \
    Trebuchet \
    audio_effects.conf

# Extra tools in CM
PRODUCT_PACKAGES += \
    openvpn

PRODUCT_PACKAGE_OVERLAYS += vendor/cm/overlay/dictionaries
PRODUCT_PACKAGE_OVERLAYS += vendor/cm/overlay/common

PRODUCT_VERSION_MAJOR = 9
PRODUCT_VERSION_MINOR = 0
PRODUCT_VERSION_MAINTENANCE = 0-0

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_DISPLAY_ID=IMM76D

ifdef CM_NIGHTLY
    CM_VERSION :=$(PRODUCT_VERSION_MAJOR)-$(shell date +%Y%m%d)-NIGHTLY-$(CM_BUILD)
else
    ifdef CM_SNAPSHOT
        CM_VERSION := $(PRODUCT_VERSION_MAJOR)-$(shell date +%Y%m%d)-SNAPSHOT-$(CM_BUILD)$(CM_EXTRAVERSION)
    else
        ifdef CM_RELEASE
            CM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(CM_BUILD)
        else
            CM_VERSION := $(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)$(PRODUCT_VERSION_DEVICE_SPECIFIC)-$(CM_BUILD)-UNOFFICIAL
        endif
    endif
endif

PRODUCT_PROPERTY_OVERRIDES += ro.cm.version=$(CM_VERSION)

