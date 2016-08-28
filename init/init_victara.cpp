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

#include <stdlib.h>

#include "vendor_init.h"
#include "property_service.h"
#include "log.h"
#include "util.h"

void vendor_load_properties()
{
    std::string platform;
    std::string cid;
    std::string radio;

    platform = property_get("ro.board.platform");
    if (platform != ANDROID_TARGET)
        return;

    radio = property_get("ro.boot.radio");
    property_set("ro.hw.radio", radio.c_str());

    cid = property_get("ro.boot.cid");

    property_set("ro.build.product", "victara");
    property_set("ro.product.device", "victara");

    if (cid == "0xE") {
        /* xt1097 */
        property_set("ro.product.model", "XT1097");
        property_set("ro.build.description", "victara_retca-user 5.1 LPE23.32-48.1 1 release-keys");
        property_set("ro.build.fingerprint", " motorola/victara_retca/victara:5.1/LPE23.32-48.1/1:user/release-keys");
        property_set("ro.telephony.default_network", "9");
        property_set("telephony.lteOnGsmDevice", "1");
    } else if (cid == "0x7") {
        /* xt1092 */
        property_set("ro.product.model", "XT1092");
        property_set("ro.build.description", "victara_reteu-user 5.1 LPE23.32-25.1 1 release-keys");
        property_set("ro.build.fingerprint", " motorola/victara_reteu/victara:5.1/LPE23.32-25.1/1:user/release-keys");
        property_set("ro.telephony.default_network", "9");
        property_set("telephony.lteOnGsmDevice", "1");
    } else if (cid == "0x2") {
        /* xt1096 */
        property_set("ro.product.model", "XT1096");
        property_set("ro.build.description", "victara_verizon-user 5.1 LPE23.32-25-3 10 release-keys");
        property_set("ro.build.fingerprint", "motorola/victara_verizon/victara:5.1/LPE23.32-25-3/10:user/release-keys");
        property_set("ro.telephony.default_network", "10");
        property_set("telephony.lteOnCdmaDevice", "1");
        property_set("ro.telephony.default_cdma_sub", "0");
        property_set("ro.ril.force_eri_from_xml", "true");
        property_set("ro.telephony.get_imsi_from_sim", "true");
        property_set("ro.com.google.clientidbase.am", "android-verizon");
        property_set("ro.com.google.clientidbase.ms", "android-verizon");
        property_set("ro.com.google.clientidbase.yt", "android-verizon");
        property_set("ro.cdma.data_retry_config", "max_retries=infinite,0,0,10000,10000,100000,10000,10000,10000,10000,140000,540000,960000");
    } else if (cid == "0x9") {
        /* xt1093 */
        property_set("ro.product.model", "XT1093");
        property_set("ro.build.description", "victara_usc-user 5.1 LPE23.32-21.7 1 release-keys");
        property_set("ro.build.fingerprint", "motorola/victara_usc/victara:5.1/LPE23.32-21.7/1:user/release-keys");
        property_set("ro.telephony.default_network", "10");
        property_set("telephony.lteOnCdmaDevice", "1");
        property_set("ro.com.google.clientidbase.am", "android-uscellular-us");
        property_set("ro.com.google.clientidbase.ms", "android-uscellular-us");
        property_set("ro.cdma.data_retry_config", "max_retries=infinite,0,0,10000,10000,100000,10000,10000,10000,10000,140000,540000,960000");
    } else {
        /* all others */
        property_set("ro.product.model", "XT1095");
        property_set("ro.build.description", "victara_tmo-user 5.1 LPE23.32-21.3 5 release-keys");
        property_set("ro.build.fingerprint", "motorola/victara_tmo/victara:5.1/LPE23.32-21.3/5:user/release-keys");
        property_set("ro.telephony.default_network", "9");
        property_set("telephony.lteOnGsmDevice", "1");
    }
}
