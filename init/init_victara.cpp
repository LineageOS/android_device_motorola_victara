/*
   Copyright (c) 2013, The Linux Foundation. All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are
   met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of The Linux Foundation nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

   THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
   WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
   MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
   ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
   BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
   CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
   SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
   BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
   WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
   OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
   IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#include <vector>

#define _REALLY_INCLUDE_SYS__SYSTEM_PROPERTIES_H_
#include <sys/_system_properties.h>

#include <android-base/properties.h>
#include <android-base/logging.h>

#include "property_service.h"
#include "vendor_init.h"

using android::base::GetProperty;
using android::init::property_set;

std::vector<std::string> ro_props_default_source_order = {
    "",
    "odm.",
    "product.",
    "system.",
    "vendor.",
};

void property_override(char const prop[], char const value[], bool add = true)
{
    prop_info *pi;

    pi = (prop_info*) __system_property_find(prop);
    if (pi)
        __system_property_update(pi, value, strlen(value));
    else if (add)
        __system_property_add(prop, strlen(prop), value, strlen(value));
}

void vendor_load_properties()
{
    std::string bootcid;
    std::string device;
    std::string radio;

    radio = GetProperty("ro.boot.radio", "");
    property_set("ro.hw.radio", radio.c_str());

    const auto set_ro_build_prop = [](const std::string &source,
            const std::string &prop, const std::string &value) {
        auto prop_name = "ro." + source + "build." + prop;
        property_override(prop_name.c_str(), value.c_str(), false);
    };

    const auto set_ro_product_prop = [](const std::string &source,
            const std::string &prop, const std::string &value) {
        auto prop_name = "ro.product." + source + prop;
        property_override(prop_name.c_str(), value.c_str(), false);
    };

    // Init a dummy BT MAC address, will be overwritten later
    property_set("ro.boot.btmacaddr", "00:00:00:00:00:00");

    bootcid = GetProperty("ro.boot.cid", "");
    if (bootcid == "0x7") {
        /* XT1092 */
        property_override("ro.build.description", "victara_reteu-user 5.1 LPE23.32-25.1 1 release-keys");
        property_set("ro.telephony.default_network", "9");
        property_set("telephony.lteOnGsmDevice", "1");
        for (const auto &source : ro_props_default_source_order) {
            set_ro_build_prop(source, "fingerprint", "motorola/victara_reteu/victara:5.1/LPE23.32-25.1/1:user/release-keys");
            set_ro_product_prop(source, "device", "victara");
            set_ro_product_prop(source, "model", "XT1092");
            set_ro_product_prop(source, "name", "victara");
        }
    } else if (bootcid == "0x9") {
        /* XT1093 */
        property_override("ro.build.description", "victara_usc-user 5.1 LPE23.32-21.7 1 release-keys");
        property_set("ro.telephony.default_network", "10");
        property_set("telephony.lteOnCdmaDevice", "1");
        property_set("ro.com.google.clientidbase.am", "android-uscellular-us");
        property_set("ro.com.google.clientidbase.ms", "android-uscellular-us");
        property_set("ro.cdma.data_retry_config", "max_retries=infinite,0,0,10000,10000,100000,10000,10000,10000,10000,140000,540000,960000");
        for (const auto &source : ro_props_default_source_order) {
            set_ro_build_prop(source, "fingerprint", "motorola/victara_usc/victara:5.1/LPE23.32-21.7/1:user/release-keys");
            set_ro_product_prop(source, "device", "victara");
            set_ro_product_prop(source, "model", "XT1093");
            set_ro_product_prop(source, "name", "victara");
        }
    } else if ((bootcid == "0x2") || (bootcid == "0xDEAD")) {
        /* XT1096 */
        property_override("ro.build.description", "victara_verizon-user 5.1 LPE23.32-25-3 10 release-keys");
        property_set("ro.telephony.default_network", "10");
        property_set("telephony.lteOnCdmaDevice", "1");
        property_set("ro.telephony.default_cdma_sub", "0");
        property_set("ro.ril.force_eri_from_xml", "true");
        property_set("ro.telephony.get_imsi_from_sim", "true");
        property_set("ro.com.google.clientidbase.am", "android-verizon");
        property_set("ro.com.google.clientidbase.ms", "android-verizon");
        property_set("ro.com.google.clientidbase.yt", "android-verizon");
        property_set("ro.cdma.data_retry_config", "max_retries=infinite,0,0,10000,10000,100000,10000,10000,10000,10000,140000,540000,960000");
        for (const auto &source : ro_props_default_source_order) {
            set_ro_build_prop(source, "fingerprint", "motorola/victara_verizon/victara:5.1/LPE23.32-25-3/10:user/release-keys");
            set_ro_product_prop(source, "device", "victara");
            set_ro_product_prop(source, "model", "XT1096");
            set_ro_product_prop(source, "name", "victara");
        }
    } else if ((bootcid == "0xE") || (bootcid == "0xC") || (bootcid == "0x0")) {
        /* XT1097 */
        property_override("ro.build.description", "victara_retca-user 5.1 LPE23.32-48.1 1 release-keys");
        property_set("ro.telephony.default_network", "9");
        property_set("telephony.lteOnGsmDevice", "1");
        for (const auto &source : ro_props_default_source_order) {
            set_ro_build_prop(source, "fingerprint", "motorola/victara_retca/victara:5.1/LPE23.32-48.1/1:user/release-keys");
            set_ro_product_prop(source, "device", "victara");
            set_ro_product_prop(source, "model", "XT1097");
            set_ro_product_prop(source, "name", "victara");
        }
    } else {
        /* XT1095 & All other GSM variants */
        property_override("ro.build.description", "victara_tmo-user 5.1 LPE23.32-21.3 5 release-keys");
        property_set("ro.telephony.default_network", "9");
        property_set("telephony.lteOnGsmDevice", "1");
        for (const auto &source : ro_props_default_source_order) {
            set_ro_build_prop(source, "fingerprint", "motorola/victara_tmo/victara:5.1/LPE23.32-21.3/5:user/release-keys");
            set_ro_product_prop(source, "device", "victara");
            set_ro_product_prop(source, "model", "XT1095");
            set_ro_product_prop(source, "name", "victara");
        }
    }

    device = GetProperty("ro.product.device", "");
    LOG(ERROR) << "Found bootcid '" << bootcid.c_str() << "' setting build properties for '" << device.c_str() << "' device\n";
}
