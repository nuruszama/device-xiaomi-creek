#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from creek device
$(call inherit-product, device/xiaomi/creek/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Include our private certificate
-include vendor/lineage-priv/keys/keys.mk

# Gapps
# -include vendor/gms/products/gms.mk

# Gapps config
TARGET_SUPPORTS_GOOGLE_RECORDER := true
TARGET_INCLUDE_STOCK_ARCORE := false
TARGET_INCLUDE_GOOGLE_COMMS := true
TARGET_INCLUDE_PIXEL_LAUNCHER := true
TARGET_INCLUDE_LIVE_WALLPAPERS := false
WITH_GMS := true

# AudioFX
TARGET_EXCLUDES_AUDIOFX := true

# Device configs
TARGET_BOOT_ANIMATION_RES = 1080
TARGET_HAS_UDFPS := false

PRODUCT_NAME := lineage_creek
PRODUCT_DEVICE := creek
PRODUCT_BRAND := Xiaomi
PRODUCT_MODEL := POCO M7 4G

PRODUCT_GMS_CLIENTID_BASE := android-xiaomi

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="creek_p_global-user 16 BP2A.250605.031.A3 OS3.0.10.0.WBOMIXM release-keys" \
    BuildFingerprint="POCO/creek_p_global/creek:16/BP2A.250605.031.A3/OS3.0.10.0.WBOMIXM:user/release-keys"
