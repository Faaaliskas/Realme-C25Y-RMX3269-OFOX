#
# Copyright (C) 2026 The Android Open Source Project
# Copyright (C) 2026 The TWRP / OrangeFox Open Source Project
#

LOCAL_PATH := device/realme/RMX3269

# Dynamic Partitions
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Enable Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Fastbootd
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Update engine (A/B)
PRODUCT_PACKAGES += \
    update_engine \
    update_engine_sideload \
    update_verifier

# Crypto / Keymaster / Gatekeeper
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Recovery init files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/init.recovery.ums512.rc:root/init.recovery.ums512.rc \
    $(LOCAL_PATH)/recovery/root/init.recovery.ums512.rc:root/init.recovery.RMX3265.rc \
    $(LOCAL_PATH)/recovery/root/ueventd.ums512.rc:root/ueventd.ums512.rc \
    $(LOCAL_PATH)/recovery/root/ueventd.ums512.rc:root/ueventd.RMX3265.rc
