#
# Copyright (C) 2014 The CyanogenMod Project
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

$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

$(call inherit-product, vendor/motorola/victara/victara-vendor.mk)

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/vendor/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.nfc.hce.xml:system/vendor/etc/permissions/android.hardware.nfc.hce.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/vendor/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

# Motorola-specific permissions
PRODUCT_COPY_FILES += \
    device/motorola/victara/permissions/com.motorola.actions.xml:system/etc/permissions/com.motorola.actions.xml \
    device/motorola/victara/permissions/com.motorola.android.dm.service.xml:system/etc/permissions/com.motorola.android.dm.service.xml \
    device/motorola/victara/permissions/com.motorola.android.encryption_library.xml:system/etc/permissions/com.motorola.android.encryption_library.xml \
    device/motorola/victara/permissions/com.motorola.android.tcmd.xml:system/etc/permissions/com.motorola.android.tcmd.xml \
    device/motorola/victara/permissions/com.motorola.aon.quickpeek.xml:system/etc/permissions/com.motorola.aon.quickpeek.xml \
    device/motorola/victara/permissions/com.motorola.aov.xml:system/etc/permissions/com.motorola.aov.xml \
    device/motorola/victara/permissions/com.motorola.avatar.xml:system/etc/permissions/com.motorola.avatar.xml \
    device/motorola/victara/permissions/com.motorola.camerabgproc_library.xml:system/etc/permissions/com.motorola.camerabgproc_library.xml \
    device/motorola/victara/permissions/com.motorola.camera.xml:system/etc/permissions/com.motorola.camera.xml \
    device/motorola/victara/permissions/com.motorola.fpsmotosignature.xml:system/etc/permissions/com.motorola.fpsmotosignature.xml \
    device/motorola/victara/permissions/com.motorola.frameworks.core.addon.xml:system/etc/permissions/com.motorola.frameworks.core.addon.xml \
    device/motorola/victara/permissions/com.motorola.gallery.xml:system/etc/permissions/com.motorola.gallery.xml \
    device/motorola/victara/permissions/com.motorola.haptic.xml:system/etc/permissions/com.motorola.haptic.xml \
    device/motorola/victara/permissions/com.motorola.moodle.library.xml:system/etc/permissions/com.motorola.moodle.library.xml \
    device/motorola/victara/permissions/com.motorola.motodisplay.pd.screenoff.xml:system/etc/permissions/com.motorola.motodisplay.pd.screenoff.xml \
    device/motorola/victara/permissions/com.motorola.motosignature.xml:system/etc/permissions/com.motorola.motosignature.xml \
    device/motorola/victara/permissions/com.motorola.moto.xml:system/etc/permissions/com.motorola.moto.xml \
    device/motorola/victara/permissions/com.motorola.pixelpipe.xml:system/etc/permissions/com.motorola.pixelpipe.xml \
    device/motorola/victara/permissions/com.motorola.sensorhub.stm401.xml:system/etc/permissions/com.motorola.sensorhub.stm401.xml \
    device/motorola/victara/permissions/com.motorola.slpc.xml:system/etc/permissions/com.motorola.slpc.xml \
    device/motorola/victara/permissions/com.motorola.software.bodyguard.xml:system/etc/permissions/com.motorola.software.bodyguard.xml \
    device/motorola/victara/permissions/com.motorola.software.guideme.xml:system/etc/permissions/com.motorola.software.guideme.xml \
    device/motorola/victara/permissions/com.motorola.software.smartnotifications.xml:system/etc/permissions/com.motorola.software.smartnotifications.xml \
    device/motorola/victara/permissions/com.motorola.software.x_line.xml:system/etc/permissions/com.motorola.software.x_line.xml \
    device/motorola/victara/permissions/com.motorola.targetnotif.xml:system/etc/permissions/com.motorola.targetnotif.xml

PRODUCT_CHARACTERISTICS := nosdcard

# Screen density
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# Bluetooth HAL
PRODUCT_PACKAGES += \
    android.hardware.bluetooth@1.0-impl \
    libbt-vendor

# Boot animation
TARGET_SCREEN_HEIGHT := 1920
TARGET_SCREEN_WIDTH := 1080

# Dalvik heap
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.heapstartsize=16m \
    dalvik.vm.heapgrowthlimit=192m \
    dalvik.vm.heapsize=512m \
    dalvik.vm.heaptargetutilization=0.75 \
    dalvik.vm.heapminfree=2m \
    dalvik.vm.heapmaxfree=8m

# Art
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.dex2oat-swap=false

# Memory optimizations
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.qti.am.reschedule_service=true \
    ro.vendor.qti.sys.fw.bservice_enable=true

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
    libqcomvoiceprocessing

PRODUCT_PACKAGES += \
    mbhc.bin \
    wcd9310_anc.bin

# Audio configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/audio/audio_effects.xml:system/vendor/etc/audio_effects.xml \
    $(LOCAL_PATH)/audio/audio_platform_info.xml:system/vendor/etc/audio_platform_info.xml \
    $(LOCAL_PATH)/audio/audio_policy.conf:system/vendor/etc/audio_policy.conf \
    $(LOCAL_PATH)/audio/mixer_paths.xml:system/vendor/etc/mixer_paths.xml

# Camera
PRODUCT_PACKAGES += \
    android.hardware.camera.provider@2.4-impl \
    camera.device@1.0-impl \
    Snap \
    libshim_camera \
    libshims_sensorlistener \
    camera.msm8974

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/hdrhax:system/vendor/etc/hdrhax \
    $(LOCAL_PATH)/configs/external_camera_config.xml:$(TARGET_COPY_OUT_VENDOR)/etc/external_camera_config.xml


# CRDA
PRODUCT_PACKAGES += \
    crda \
    linville.key.pub.pem \
    regdbdump \
    regulatory.bin

# DRM
PRODUCT_PACKAGES += \
    android.hardware.drm@1.0-impl \
    android.hardware.drm@1.0-service

# Display
PRODUCT_PACKAGES += \
    android.hardware.graphics.allocator@2.0-impl \
    android.hardware.graphics.mapper@2.0-impl \
    android.hardware.graphics.composer@2.1-impl \
    android.hardware.graphics.memtrack@1.0-impl \
    copybit.msm8974 \
    gralloc.msm8974 \
    hwcomposer.msm8974 \
    libgenlock \
    memtrack.msm8974

# GNSS HAL
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-impl

# GPS
PRODUCT_PACKAGES += \
    android.hardware.gnss@1.0-impl \
    gps.msm8974

# Health
PRODUCT_PACKAGES += \
    android.hardware.health@2.0-impl \
    android.hardware.health@2.0-service

# IPv6 tethering
PRODUCT_PACKAGES += \
    ebtables \
    ethertypes

# IRSC
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sec_config:$(TARGET_COPY_OUT_VENDOR)/etc/sec_config

# Keylayout
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/keylayout/sensorprocessor.kl:system/usr/keylayout/sensorprocessor.kl

# Keystore
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl \
    keystore.msm8974

# Lights
PRODUCT_PACKAGES += \
    android.hardware.light@2.0-impl \
    lights.msm8974

# Perf
PRODUCT_PACKAGES += \
    libshims_atomic

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    $(LOCAL_PATH)/configs/media_codecs_performance.xml:system/etc/media_codecs_performance.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml

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
    device/motorola/victara/nfc/libnfc-nci.conf:system/vendor/etc/libnfc-nci.conf \
    device/motorola/victara/nfc/libnfc-nci-20795a10.conf:system/vendor/etc/libnfc-nci-20795a10.conf

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

# Power HAL
PRODUCT_PACKAGES += \
    android.hardware.power@1.1-service-qti

# Offmode Charging
PRODUCT_PACKAGES += \
    charger_res_image

# Ramdisk
PRODUCT_PACKAGES += \
    init.qcom.bt.sh

PRODUCT_PACKAGES += \
    fstab.qcom \
    init.mmi.boot.sh \
    init.mmi.radio.sh \
    init.mmi.rc \
    init.mmi.touch.sh \
    init.mmi.usb.rc \
    init.qcom.rc \
    init.qcom.usb.rc \
    init.recovery.qcom.rc \
    init.target.rc \
    ueventd.qcom.rc

# Seccomp
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/seccomp/mediacodec.policy:system/vendor/etc/seccomp_policy/mediacodec.policy \
    $(LOCAL_PATH)/seccomp/mediaextractor.policy:system/vendor/etc/seccomp_policy/mediaextractor.policy

# RenderScript HAL
PRODUCT_PACKAGES += \
    android.hardware.renderscript@1.0-impl

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@1.0-impl

# Support
PRODUCT_PACKAGES += \
    libcnefeatureconfig \
    libcurl \
    libxml2

# RIL Shim
PRODUCT_PACKAGES += \
    libqsap_shim

# Thermal
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermal-engine-victara.conf:system/etc/thermal-engine-victara.conf

PRODUCT_PACKAGES += \
    libshims_thermal

# Torch
PRODUCT_PACKAGES += \
    Torch

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb@1.0-service.basic

# Vibrator
PRODUCT_PACKAGES += \
    android.hardware.vibrator@1.0-impl

# Wifi
PRODUCT_PACKAGES += \
    android.hardware.wifi@1.0-service \
    hostapd \
    hostapd.accept \
    hostapd.deny \
    libqsap_sdk \
    libwpa_client \
    wificond \
    wcnss_service \
    wpa_supplicant \
    wificond

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/wpa_supplicant.conf:system/vendor/etc/wifi/wpa_supplicant.conf \
    $(LOCAL_PATH)/configs/wpa_supplicant_overlay.conf:system/vendor/etc/wifi/wpa_supplicant_overlay.conf \
    $(LOCAL_PATH)/configs/p2p_supplicant_overlay.conf:system/vendor/etc/wifi/p2p_supplicant_overlay.conf

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_cfg.ini:system/vendor/firmware/wlan/prima/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/wifi/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    $(LOCAL_PATH)/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin

# LineageActions
PRODUCT_PACKAGES += \
    LineageActions \
    libjni_LineageActions

# Keymaster HIDL interfaces
PRODUCT_PACKAGES += \
    android.hardware.keymaster@3.0-impl
