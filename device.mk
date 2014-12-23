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

$(call inherit-product, vendor/motorola/ghost/ghost-vendor.mk)

# Overlay
DEVICE_PACKAGE_OVERLAYS += $(LOCAL_PATH)/overlay

# Permissions
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
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
    frameworks/native/data/etc/com.android.nfc_extras.xml:system/etc/permissions/com.android.nfc_extras.xml \
    frameworks/native/data/etc/com.nxp.mifare.xml:system/etc/permissions/com.nxp.mifare.xml \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml

# System Properties
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# Screen density
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi
PRODUCT_AAPT_PREF_CONFIG := xhdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 1280
TARGET_SCREEN_WIDTH := 720

$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)

# Audio
PRODUCT_PACKAGES += \
    audio.a2dp.default \
    audio.primary.msm8960 \
    audio.r_submix.default \
    audio.usb.default \
    audio_policy.msm8960 \
    libaudio-resampler

PRODUCT_PACKAGES += \
    mbhc.bin \
    wcd9310_anc.bin

# Audio configuration
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio_policy.conf:system/etc/audio_policy.conf \
    $(LOCAL_PATH)/configs/snd_soc_msm_2x:system/etc/snd_soc_msm/snd_soc_msm_2x

# Camera
PRODUCT_PACKAGES += \
    camera.msm8960

# Charger
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# CRDA
PRODUCT_PACKAGES += \
    crda \
    linville.key.pub.pem \
    regdbdump \
    regulatory.bin

# Display
PRODUCT_PACKAGES += \
    copybit.msm8960 \
    gralloc.msm8960 \
    hwcomposer.msm8960 \
    libgenlock \
    memtrack.msm8960

# Filesystem
PRODUCT_PACKAGES += \
    e2fsck \
    fibmap.f2fs \
    fsck.f2fs \
    make_ext4fs \
    mkfs.f2fs \
    resize2fs \
    setup_fs

# IRSC
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sec_config:system/etc/sec_config

# Keylayout
PRODUCT_PACKAGES += \
    $(LOCAL_PATH)/keylayout/msp430sensorprocessor.kl:system/usr/keylayout/msp430sensorprocessor.kl

# Keystore
PRODUCT_PACKAGES += \
    keystore.msm8960

# Lights
PRODUCT_PACKAGES += \
    lights.msm8960

# Media
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/media_profiles.xml:system/etc/media_profiles.xml \
    $(LOCAL_PATH)/configs/media_codecs.xml:system/etc/media_codecs.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml

# Motorola
PRODUCT_PACKAGES += \
    charge_only_mode

# NFC
PRODUCT_PACKAGES += \
    libnfc \
    libnfc_jni \
    nfc.msm8960 \
    Nfc \
    Tag \
    com.android.nfc_extras

ifeq ($(TARGET_BUILD_VARIANT),user)
    PRODUCT_COPY_FILES += $(LOCAL_PATH)/configs/nfcee_access.xml:system/etc/nfcee_access.xml
else
    PRODUCT_COPY_FILES += $(LOCAL_PATH)/configs/nfcee_access_debug.xml:system/etc/nfcee_access.xml
endif

# OMX
PRODUCT_PACKAGES += \
    libdashplayer \
    libOmxVdec \
    libOmxVenc \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libstagefrighthw \
    qcmediaplayer

PRODUCT_BOOT_JARS += \
    qcmediaplayer

# Power HAL
PRODUCT_PACKAGES += \
    power.msm8960

# QRNGD
PRODUCT_PACKAGES += \
    qrngd

# Ramdisk
PRODUCT_PACKAGES += \
    init.crda.sh \
    init.qcom.bt.sh \
    init.qcom.coex.sh \
    init.qcom.wifi.sh \
    moto_com.sh \
    mount_pds.sh

PRODUCT_PACKAGES += \
    fstab.qcom \
    init.mmi.boot.sh \
    init.mmi.touch.sh \
    init.qcom.rc \
    init.qcom.usb.rc \
    init.recovery.qcom.rc \
    ueventd.qcom.rc

# Support
PRODUCT_PACKAGES += \
    libcurl \
    libxml2

# Thermal
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/thermald-ghost.conf:system/etc/thermald-ghost.conf

# Torch
PRODUCT_PACKAGES += \
    Torch

# USB
PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# Wifi
PRODUCT_PACKAGES += \
    dhcpcd.conf \
    hostapd \
    libQWiFiSoftApCfg \
    wpa_supplicant \
    wpa_supplicant.conf

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/hostapd.accept:system/etc/hostapd/hostapd.accept \
    $(LOCAL_PATH)/configs/hostapd.deny:system/etc/hostapd/hostapd.deny \
    $(LOCAL_PATH)/configs/hostapd_default.conf:system/etc/hostapd/hostapd_default.conf \

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf \
    $(LOCAL_PATH)/configs/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf

PRODUCT_PACKAGES += \
    WCNSS_qcom_wlan_nv.bin \
    WCNSS_qcom_wlan_nv_calibration.bin \
    WCNSS_qcom_wlan_nv_regulatory.bin \
    WCNSS_qcom_wlan_nv_calibration_0x3.bin \
    WCNSS_qcom_wlan_nv_calibration_0x4.bin \
    WCNSS_qcom_wlan_nv_calibration_0x5.bin \
    WCNSS_qcom_wlan_nv_calibration_0x6.bin \
    WCNSS_qcom_wlan_nv_regulatory_0x3.bin \
    WCNSS_qcom_wlan_nv_regulatory_0x4.bin \
    WCNSS_qcom_wlan_nv_regulatory_0x5.bin \
    WCNSS_qcom_wlan_nv_regulatory_0x6.bin

PRODUCT_COPY_FILES += \
    kernel/motorola/ghost/drivers/staging/prima_mmi/firmware_bin/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    kernel/motorola/ghost/drivers/staging/prima_mmi/firmware_bin/WCNSS_qcom_cfg.ini:system/etc/wifi/WCNSS_qcom_cfg.ini \
    $(LOCAL_PATH)/wlan/cal_files/WCNSS_qcom_wlan_nv_calibration.bin:system/etc/firmware/wlan/prima/cal_files/WCNSS_qcom_wlan_nv_calibration.bin \
    $(LOCAL_PATH)/wlan/cal_files/WCNSS_qcom_wlan_nv_calibration_0x1.bin:system/etc/firmware/wlan/prima/cal_files/WCNSS_qcom_wlan_nv_calibration_0x1.bin \
    $(LOCAL_PATH)/wlan/cal_files/WCNSS_qcom_wlan_nv_calibration_0x2.bin:system/etc/firmware/wlan/prima/cal_files/WCNSS_qcom_wlan_nv_calibration_0x2.bin \
    $(LOCAL_PATH)/wlan/cal_files/WCNSS_qcom_wlan_nv_regulatory.bin:system/etc/firmware/wlan/prima/cal_files/WCNSS_qcom_wlan_nv_regulatory.bin \
    $(LOCAL_PATH)/wlan/cal_files/WCNSS_qcom_wlan_nv_regulatory_0x1.bin:system/etc/firmware/wlan/prima/cal_files/WCNSS_qcom_wlan_nv_regulatory_0x1.bin \
    $(LOCAL_PATH)/wlan/cal_files/WCNSS_qcom_wlan_nv_regulatory_0x2.bin:system/etc/firmware/wlan/prima/cal_files/WCNSS_qcom_wlan_nv_regulatory_0x2.bin
