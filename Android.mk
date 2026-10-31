#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 The TWRP / OrangeFox Open Source Project
#

LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),RMX3269)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
