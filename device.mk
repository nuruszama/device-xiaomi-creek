#
# Minimal Boot Test device.mk (Creek)
#

# Add common definitions for Qualcomm
$(call inherit-product, hardware/qcom-caf/common/common.mk)

# Basic Android configs
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

# A/B OTA minimal config
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    FILESYSTEM_TYPE_vendor=erofs

# VERY MINIMAL PACKAGES (ONLY CORE BOOT)
PRODUCT_PACKAGES += \
    logd \
    servicemanager \
    vndservicemanager \
    vold \
    init \
    init.rc \
    init.vendor.sensors.rc \
    lmkd \
    bootanim

# Disable OpenMAX legacy media framework used in older Android versions
TARGET_SUPPORTS_OMX_SERVICE := false