#
# Copyright (C) 2022 The Android Open Source Project
# Copyright (C) 2022 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# INHERIT GSI KEYS
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# INHERIT OrangeFox / TWRP
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from RMX3269 device
$(call inherit-product, device/realme/RMX3269/device.mk)

PRODUCT_DEVICE := RMX3269
PRODUCT_NAME := twrp_RMX3269
PRODUCT_BRAND := realme
PRODUCT_MODEL := RMX3269
PRODUCT_MANUFACTURER := realme
PRODUCT_RELEASE_NAME := RMX3269
