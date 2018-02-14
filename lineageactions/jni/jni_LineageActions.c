/*
 * Copyright (C) 2015 The CyanogenMod Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "jni_LineageActions"

#include <errno.h>
#include <fcntl.h>
#include <jni.h>
#include <pthread.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include <linux/stm401.h>
#include <cutils/log.h>
#include <sys/ioctl.h>
#include <sys/stat.h>
#include <sys/types.h>

#define PACKED __attribute__((__packed__))
#define UNUSED __attribute__((__unused__))

#define STM401_DEVICE                  "/dev/stm401"
#define STM401_IR_WAKE_CONFIG_MASK      0x000007FE
#define STM401_IR_CONTROL_DISABLE       0x00000001

#define STM401_IR_CONFIG_TUNING_NUMBER_MIN 6
#define STM401_IR_CONFIG_TUNING_NUMBER_MAX 7

struct PACKED stm401_ir_led_config
{
    uint8_t  ambient_selection;
    uint16_t ambient_offset_hp;
    uint16_t idle_event_minimum_above_noise;
    uint16_t idle_hysteresis_threshold;
    uint16_t presence_event_minimum_above_noise;
    uint16_t presence_hysteresis_threshold;
    uint16_t prox_event_minimum_above_noise;
    uint16_t prox_hysteresis_threshold;
    uint16_t prox_object_close_minimum_above_noise;
    uint16_t prox_hovering_minimum_above_noise;
    uint16_t prox_covering_minimum_hp;
    uint16_t prox_covering_minimum_lp;
    uint8_t  prox_feature_support;
    uint16_t swipe_event_minimum_above_noise;
    uint16_t swipe_hysteresis_threshold;
    uint16_t swipe_complete_level1_minimum_above_idle;
    uint16_t swipe_complete_level1_minimum_threshold;
    uint16_t swipe_complete_level2_minimum_above_idle;
    uint16_t swipe_complete_level2_minimum_threshold;
    uint16_t swipe_complete_level3_minimum_above_idle;
    uint16_t swipe_complete_level3_minimum_threshold;
    uint16_t swipe_reading_high_threshold;
}; /* size = 0x2A */

struct PACKED stm401_ir_config
{
    uint8_t size;
    uint8_t tuning_number; /* 4 - 6 are valid values */
    uint32_t cmd_control;
    uint32_t cmd_config;
    struct stm401_ir_led_config top_right_config;
    struct stm401_ir_led_config bottom_left_config;
    struct stm401_ir_led_config bottom_right_config;
    struct stm401_ir_led_config bottom_both_config;
    uint16_t idle_count;
    uint8_t idle_event_count;
    uint16_t noise_minimum;
    uint8_t noise_padding;
    uint8_t noise_period;
    uint8_t object_valid_delay;
    uint8_t prox_cover_count;
    uint8_t prox_event_count;
    uint8_t prox_hower_count;
    uint8_t presence_event_count;
    uint8_t swipe_count;
    uint8_t swipe_event_count;
    uint16_t swipe_high_threshold;
    uint8_t swipe_fast_level1_threshold;
    uint8_t swipe_fast_level2_threshold;
    uint8_t swipe_is_equal_level1_threshold;
    uint8_t swipe_is_equal_level2_threshold;
    uint8_t swipe_is_equal_level3_threshold;
    uint8_t motion_scale_shift;
    uint8_t swipe_high_level1_multiplier;
    uint8_t swipe_high_level2_multiplier;
    uint16_t ambient_min_reading;
    uint16_t ambient_max_reading;
    uint8_t swipe_ignore_count;
    uint16_t swipe_vertical_pref_delta;
    uint16_t swipe_vertical_ignore_delta;
    uint8_t swipe_vertical_ignore_count;
}; /* size = 0xD4 */

static pthread_mutex_t ioctl_mutex = PTHREAD_MUTEX_INITIALIZER;

int stm401_ioctl(unsigned long request, unsigned char* data)
{
    int fd = open(STM401_DEVICE, O_RDWR);
    if (fd < 0) {
        ALOGE("%s: Failed to open " STM401_DEVICE ": %s\n", __func__, strerror(errno));
        return 1;
    }

    int ret = ioctl(fd, request, data);
    close(fd);

    if (ret) {
        ALOGE("%s: Failed to ioctl " STM401_DEVICE ": %s\n", __func__, strerror(errno));
        return 1;
    }

    return 0;
}

int read_ir_config(struct stm401_ir_config* config, int check_version)
{
    memset(config, 0, sizeof(struct stm401_ir_config));
    config->size = sizeof(struct stm401_ir_config);

    if (stm401_ioctl(STM401_IOCTL_GET_IR_CONFIG, (unsigned char*)config)) {
        return 1;
    }

    if (check_version && (config->tuning_number < STM401_IR_CONFIG_TUNING_NUMBER_MIN ||
        config->tuning_number > STM401_IR_CONFIG_TUNING_NUMBER_MAX)) {
        ALOGE("%s: Found tuning number %d, but expected %d..%d!\n", __func__,
                config->tuning_number, STM401_IR_CONFIG_TUNING_NUMBER_MIN,
                STM401_IR_CONFIG_TUNING_NUMBER_MAX);
        return 1;
    }

    return 0;
}

int write_ir_config(struct stm401_ir_config* config)
{
    return stm401_ioctl(STM401_IOCTL_SET_IR_CONFIG, (unsigned char*)config);
}

int set_ir_disabled(int disabled)
{
    struct stm401_ir_config config;

    pthread_mutex_lock(&ioctl_mutex);

    if (read_ir_config(&config, 1)) {
        goto err;
    }

    if (disabled) {
        config.cmd_control |= STM401_IR_CONTROL_DISABLE;
    } else {
        config.cmd_control &= ~STM401_IR_CONTROL_DISABLE;
    }

    if (write_ir_config(&config)) {
        goto err;
    }

    pthread_mutex_unlock(&ioctl_mutex);

    return 0;
err:
    pthread_mutex_unlock(&ioctl_mutex);
    return 1;
}

int set_ir_wake_config(int wake_config)
{
    struct stm401_ir_config config;

    pthread_mutex_lock(&ioctl_mutex);

    if (read_ir_config(&config, 1)) {
        goto err;
    }

    config.cmd_config = wake_config & STM401_IR_WAKE_CONFIG_MASK;

    if (write_ir_config(&config)) {
        goto err;
    }

     pthread_mutex_unlock(&ioctl_mutex);

    return 0;
err:
    pthread_mutex_unlock(&ioctl_mutex);
    return 1;
}

JNIEXPORT jboolean JNICALL Java_com_lineageos_settings_device_IrGestureManager_nativeSetIrDisabled(
     UNUSED JNIEnv *env, UNUSED jclass thiz, jboolean disabled)
{
    return set_ir_disabled(disabled == JNI_TRUE) ? JNI_FALSE : JNI_TRUE;
}

JNIEXPORT jboolean JNICALL Java_com_lineageos_settings_device_IrGestureManager_nativeSetIrWakeConfig(
     UNUSED JNIEnv *env, UNUSED jclass thiz, jint wakeConfig)
{
    return set_ir_wake_config((int)wakeConfig) ? JNI_FALSE : JNI_TRUE;
}
