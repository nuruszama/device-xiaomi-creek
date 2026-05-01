#
# Minimal Boot Test device.mk (Creek)
#

# Add common definitions for Qualcomm
# $(call inherit-product, hardware/qcom-caf/common/common.mk)

# Inherit from common AOSP 64-bit phone config
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/mainline_system.mk)

# Dalvik
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# APEX
$(call inherit-product, $(SRC_TARGET_DIR)/product/updatable_apex.mk)

# Ramdisk Security
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

# Storage
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)

# Inherit from the proprietary vendor version
# $(call inherit-product, vendor/xiaomi/creek/creek-vendor.mk)

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

# CORE BOOT PACKAGES (Minimal & Functional)
PRODUCT_PACKAGES += \
    init.creek.rc \
    init.creek.hw.rc \
    init.target.rc \
    fstab.zram \
    fstab.default \
    init.vendor.sensors.rc \
    init.qti.display_boot.rc \
    logd \
    servicemanager \
    vndservicemanager \
    vold \
    bootanim \
    lmkd
    
# Needed for mounting and storage
PRODUCT_PACKAGES += \
    checkpoint_gc \
    e2fsck.recovery

# USB
PRODUCT_PACKAGES += \
    android.hardware.usb-service.qti \
    android.hardware.usb.gadget-service.qti

PRODUCT_PACKAGES += \
    init.qcom.usb.rc \
    init.qcom.usb.sh

PRODUCT_SOONG_NAMESPACES += \
    vendor/qcom/opensource/usb/etc
    
# VINTF & Compatibility
PRODUCT_SET_DEBUGFS_RESTRICTIONS := true

# Copy the custom init scripts to the vendor image
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.creek.hw.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.creek.hw.rc \
    $(LOCAL_PATH)/rootdir/etc/init.target.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.target.rc

# Disable OpenMAX legacy media framework used in older Android versions
TARGET_SUPPORTS_OMX_SERVICE := false

# Fastbootd support for easier debugging
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.1-impl-mock \
    fastbootd