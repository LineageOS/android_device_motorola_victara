#
# Copyright (C) 2014 The CyanogenMod Project
# Copyright (C) 2020 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit proprietary vendor
$(call inherit-product, vendor/motorola/victara/victara-vendor.mk)

# APEX
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/ld.config.txt:$(TARGET_COPY_OUT_SYSTEM)/etc/swcodec/ld.config.txt

# Asset density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Audio
PRODUCT_PACKAGES += \
    android.hardware.audio@2.0-impl \
    android.hardware.audio.effect@2.0-impl \
    android.hardware.broadcastradio@1.0-impl \
    android.hardware.soundtrigger@2.0-impl \
    audio.a2dp.default \
    audio_policy.msm8974 \
    audio.primary.msm8974 \
    audio.r_submix.default \
    audio.usb.default \
    libaudio-resampler \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    mbhc.bin \
    wcd9310_anc.bin

# Audio configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
    $(LOCAL_PATH)/audio/audio_platform_info.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/audio/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:system/vendor/etc/a2dp_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/audio_policy_volumes.xml:system/vendor/etc/audio_policy_volumes.xml \
    frameworks/av/services/audiopolicy/config/default_volume_tables.xml:system/vendor/etc/default_volume_tables.xml \
    frameworks/av/services/audiopolicy/config/r_submix_audio_policy_configuration.xml:system/vendor/etc/r_submix_audio_policy_configuration.xml \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:system/vendor/etc/usb_audio_policy_configuration.xml

# Bluetooth
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    libbt-vendor

# Boot animation
TARGET_BOOTANIMATION_HALF_RES := true
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    camera.device@1.0-impl \
    camera.msm8974 \
    libbson \
    libshim_camera \
    libshims_sensorlistener \
    Snap

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/camera/hdrhax:system/etc/hdrhax

# Charateristics
PRODUCT_CHARACTERISTICS := nosdcard

# CRDA
PRODUCT_PACKAGES += \
    crda \
    linville.key.pub.pem \
    regdbdump \
    regulatory.bin

# CryptfsHW
PRODUCT_PACKAGES += \
    vendor.qti.hardware.cryptfshw@1.0-service-qti.qsee

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.allocator@2.0-service \
    android.hardware.graphics.mapper@2.0-impl-2.1 \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.memtrack@1.0-impl \
    copybit.msm8974 \
    gralloc.msm8974 \
    hwcomposer.msm8974 \
    libgenlock \
    memtrack.msm8974

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.0-service \
    android.hardware.drm@1.2-service.clearkey

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-impl \
    android.hardware.gnss@1.0-service \
    gps.msm8974

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-impl \
    android.hardware.health@2.0-service

# Init scripts
PRODUCT_PACKAGES += \
    fstab.qcom \
    init.mmi.boot.sh \
    init.mmi.radio.sh \
    init.mmi.rc \
    init.mmi.touch.sh \
    init.mmi.usb.rc \
    init.qcom.rc \
    init.qcom.bt.sh \
    init.qcom.usb.rc \
    init.target.rc \
    ueventd.qcom.rc

# IPv6 tethering
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes

# IRSC
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sec_config:$(TARGET_COPY_OUT_VENDOR)/etc/sec_config

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/sensorprocessor.kl:$(TARGET_COPY_OUT_SYSTEM)/usr/keylayout/sensorprocessor.kl

# Keystore
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    android.hardware.keymaster@3.0-service \
    keystore.msm8974

# Languages
$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-service.victara

# LineageActions
PRODUCT_PACKAGES += \
    LineageActions \
    libjni_LineageActions

# LiveDisplay
PRODUCT_PACKAGES += \
    vendor.lineage.livedisplay@2.0-service-sysfs

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/media/media_profiles.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_profiles.xml \
    $(LOCAL_PATH)/media/media_codecs.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_codecs.xml \
    $(LOCAL_PATH)/media/media_codecs_performance.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_codecs_performance.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/media_codecs_google_video.xml

# NFC
PRODUCT_PACKAGES += \
    android.hardware.nfc@1.0-impl-bcm \
    libnfc \
    libnfc_jni \
    android.hardware.nfc@1.0-service \
    nfc_nci.bcm2079x.default \
    NfcNci \
    Tag \
    com.android.nfc_extras

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/nfc/libnfc-nci.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nci.conf \
    $(LOCAL_PATH)/nfc/libnfc-nci-20795a10.conf:$(TARGET_COPY_OUT_VENDOR)/etc/libnfc-nci-20795a10.conf

# Offmode Charging
PRODUCT_PACKAGES += \
    charger_res_image

# OMX
PRODUCT_PACKAGES += \
    libc2dcolorconvert \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxCore \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libOmxVdec \
    libOmxVenc \
    libstagefrighthw

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Perf
PRODUCT_PACKAGES += \
    libshims_atomic

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/handheld_core_hardware.xml

# Permissions (Motorola-specific)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/permissions/com.motorola.actions.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.actions.xml \
    $(LOCAL_PATH)/permissions/com.motorola.android.dm.service.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.android.dm.service.xml \
    $(LOCAL_PATH)/permissions/com.motorola.android.encryption_library.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.android.encryption_library.xml \
    $(LOCAL_PATH)/permissions/com.motorola.android.tcmd.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.android.tcmd.xml \
    $(LOCAL_PATH)/permissions/com.motorola.aon.quickpeek.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.aon.quickpeek.xml \
    $(LOCAL_PATH)/permissions/com.motorola.aov.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.aov.xml \
    $(LOCAL_PATH)/permissions/com.motorola.avatar.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.avatar.xml \
    $(LOCAL_PATH)/permissions/com.motorola.camerabgproc_library.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.camerabgproc_library.xml \
    $(LOCAL_PATH)/permissions/com.motorola.camera.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.camera.xml \
    $(LOCAL_PATH)/permissions/com.motorola.fpsmotosignature.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.fpsmotosignature.xml \
    $(LOCAL_PATH)/permissions/com.motorola.frameworks.core.addon.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.frameworks.core.addon.xml \
    $(LOCAL_PATH)/permissions/com.motorola.gallery.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.gallery.xml \
    $(LOCAL_PATH)/permissions/com.motorola.haptic.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.haptic.xml \
    $(LOCAL_PATH)/permissions/com.motorola.moodle.library.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.moodle.library.xml \
    $(LOCAL_PATH)/permissions/com.motorola.motodisplay.pd.screenoff.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.motodisplay.pd.screenoff.xml \
    $(LOCAL_PATH)/permissions/com.motorola.motosignature.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.motosignature.xml \
    $(LOCAL_PATH)/permissions/com.motorola.moto.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.moto.xml \
    $(LOCAL_PATH)/permissions/com.motorola.pixelpipe.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.pixelpipe.xml \
    $(LOCAL_PATH)/permissions/com.motorola.sensorhub.stm401.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.sensorhub.stm401.xml \
    $(LOCAL_PATH)/permissions/com.motorola.slpc.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.slpc.xml \
    $(LOCAL_PATH)/permissions/com.motorola.software.bodyguard.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.software.bodyguard.xml \
    $(LOCAL_PATH)/permissions/com.motorola.software.guideme.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.software.guideme.xml \
    $(LOCAL_PATH)/permissions/com.motorola.software.smartnotifications.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.software.smartnotifications.xml \
    $(LOCAL_PATH)/permissions/com.motorola.software.x_line.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.software.x_line.xml \
    $(LOCAL_PATH)/permissions/com.motorola.targetnotif.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/permissions/com.motorola.targetnotif.xml

# Power
PRODUCT_PACKAGES += \
    android.hardware.power@1.2-service-qti

# RenderScript
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

# RIL
PRODUCT_PACKAGES += \
    libqsap_shim

# RRO
PRODUCT_ENFORCE_RRO_TARGETS := \
    framework-res

# Seccomp
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/seccomp/mediacodec.policy:$(TARGET_COPY_OUT_VENDOR)/etc/seccomp_policy/mediacodec.policy

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl

# Shipping API level
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_k.mk)

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Support
PRODUCT_PACKAGES += \
    libcnefeatureconfig \
    libcurl \
    libxml2

# Thermal
PRODUCT_PACKAGES += \
    libshims_thermal

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine-victara.conf:$(TARGET_COPY_OUT_SYSTEM)/etc/thermal-engine-victara.conf

# Torch
PRODUCT_PACKAGES += \
    Torch

# Trust
PRODUCT_PACKAGES += \
    vendor.lineage.trust@1.0-service

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service.basic

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-impl \
    android.hardware.vibrator@1.0-service

# Wifi
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service.legacy \
    hostapd \
    hostapd.accept \
    hostapd.deny \
    libqsap_sdk \
    libwpa_client \
    wificond \
    wcnss_service \
    wpa_supplicant \
    wpa_supplicant.conf \
    wificond

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/p2p_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/wifi/wpa_supplicant_overlay.conf:$(TARGET_COPY_OUT_VENDOR)/etc/wifi/wpa_supplicant_overlay.conf \
    $(LOCAL_PATH)/wifi/WCNSS_cfg.dat:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_cfg.ini:$(TARGET_COPY_OUT_VENDOR)/firmware/wlan/prima/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_wlan_nv.bin:$(TARGET_COPY_OUT_SYSTEM)/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin
