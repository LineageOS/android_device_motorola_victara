LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := libloc_core
LOCAL_MODULE_OWNER := qcom

LOCAL_MODULE_TAGS := optional

LOCAL_SHARED_LIBRARIES := \
    libandroid_runtime \
    liblog \
    libutils \
    libcutils \
    libgps.utils \
    libdl \
    libprocessgroup

LOCAL_SRC_FILES += \
    MsgTask.cpp \
    LocApiBase.cpp \
    LocAdapterBase.cpp \
    ContextBase.cpp \
    LocDualContext.cpp \
    loc_core_log.cpp

LOCAL_CFLAGS += \
    -fno-short-enums \
    -D_ANDROID_ \
    -Wno-format \
    -Wno-null-conversion \
    -Wno-overloaded-virtual \
    -Wno-reorder \
    -Wno-unneeded-internal-declaration \
    -Wno-unused-parameter \
    -Wno-unused-variable

LOCAL_C_INCLUDES:= \
    $(TARGET_OUT_HEADERS)/gps.utils \
    $(TARGET_OUT_HEADERS)/libflp

LOCAL_HEADER_LIBRARIES := libgps.utils_headers

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE := libloc_core_headers
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LOCAL_PATH)
include $(BUILD_HEADER_LIBRARY)
