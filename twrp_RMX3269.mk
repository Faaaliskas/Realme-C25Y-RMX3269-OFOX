#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 The TWRP / OrangeFox Open Source Project
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# Inherit from OrangeFox / TWRP configuration
$(call inherit-product, vendor/twrp/config/common.mk)

# Inherit from device configuration
$(call inherit-product, device/realme/RMX3269/device.mk)

# Device identifier
PRODUCT_DEVICE := RMX3269
PRODUCT_NAME := twrp_RMX3269
PRODUCT_BRAND := realme
PRODUCT_MODEL := RMX3269
PRODUCT_MANUFACTURER := realme
PRODUCT_RELEASE_NAME := Realme C25Y
