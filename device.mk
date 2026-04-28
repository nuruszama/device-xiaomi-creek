#
# Minimal Boot Test device.mk (Creek)
#

# Add common definitions for Qualcomm
#$(call inherit-product, hardware/qcom-caf/common/common.mk)

# Inherit from common AOSP 64-bit phone config
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/mainline_system.mk)

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

# CORE BOOT PACKAGES (VERY MINIMAL)
PRODUCT_PACKAGES += \
    init.creek.rc \
    init.vendor.sensors.rc \
    fstab.default \
    logd \
    servicemanager \
    vndservicemanager \
    vold \
    linkerconfig \
    sh \
    toolbox \
    toybox \
    bootanim \
    lmkd

# Needed for mounting and storage
PRODUCT_PACKAGES += \
    checkpoint_gc \
    e2fsck.recovery

# VINTF & Compatibility
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

# Disable OpenMAX legacy media framework used in older Android versions
TARGET_SUPPORTS_OMX_SERVICE := false

# Fastbootd support for easier debugging
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd