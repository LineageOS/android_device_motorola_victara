#
# Copyright (C) 2014 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
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

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from victara device
$(call inherit-product, device/motorola/victara/device.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := victara
PRODUCT_NAME := full_victara
PRODUCT_BRAND := motorola
PRODUCT_MODEL := victara
PRODUCT_MANUFACTURER := motorola

# Blacklist the unified device properties
# TODO: these probably don't all need to be set
#       ro.product.device and ro.build.fingerprint can't be blacklisted, otherwise build fails
PRODUCT_SYSTEM_PROPERTY_BLACKLIST += \
    ro.build.description \
    ro.build.fingerprint \
    ro.build.product \
    ro.cdma.data_retry_config \
    ro.com.google.clientidbase.am \
    ro.com.google.clientidbase.ms \
    ro.com.google.clientidbase.yt \
    ro.hw.radio \
    ro.product.device \
    ro.product.model \
    ro.ril.force_eri_from_xml \
    ro.telephony.default_cdma_sub \
    ro.telephony.default_network \
    ro.telephony.get_imsi_from_sim \
    telephony.lteOnCdmaDevice \
    telephony.lteOnGsmDevice
