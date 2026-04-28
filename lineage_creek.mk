#
# Minimal Product Config for Boot Test (Creek)
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Inherit from creek device
$(call inherit-product, device/xiaomi/creek/device.mk)

# Basic identifiers
PRODUCT_NAME := lineage_creek
PRODUCT_DEVICE := creek
PRODUCT_MANUFACTURER := Xiaomi
PRODUCT_BRAND := POCO
PRODUCT_MODEL := POCO M7 4G

# Gapps config (disabled)
WITH_GMS := false
TARGET_SUPPORTS_GOOGLE_RECORDER := false
TARGET_INCLUDE_STOCK_ARCORE := false
TARGET_INCLUDE_GOOGLE_COMMS := false
TARGET_INCLUDE_PIXEL_LAUNCHER := false
TARGET_INCLUDE_LIVE_WALLPAPERS := false

# AudioFX
TARGET_EXCLUDES_AUDIOFX := true