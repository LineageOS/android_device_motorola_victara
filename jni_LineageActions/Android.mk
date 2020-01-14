LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := jni_LineageActions.c
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libjni_LineageActions
LOCAL_SHARED_LIBRARIES := libcutils liblog
LOCAL_HEADER_LIBRARIES := generated_kernel_headers
include $(BUILD_SHARED_LIBRARY)
