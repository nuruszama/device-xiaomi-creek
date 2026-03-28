#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from the proprietary version
# include vendor/xiaomi/creek/BoardConfigVendor.mk

DEVICE_PATH := device/xiaomi/creek
KERNEL_PATH := device/xiaomi/creek/prebuilt

# Broken Rules (Required for blob compatibility)
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_INCORRECT_PARTITION_IMAGES := true
BOARD_HAS_REMOVABLE_STORAGE := true

# Primary Architecture (64-bit)
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_VARIANT_RUNTIME := cortex-a73

# Secondary Architecture (32-bit)
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a53

# Platform
BOARD_USES_QCOM_HARDWARE := true
TARGET_BOARD_PLATFORM := bengal
TARGET_BOARD_SUFFIX := _515
TARGET_BOOTLOADER_BOARD_NAME := bengal

# Kernel - Configuration
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64
TARGET_KERNEL_VERSION := 5.15
BOARD_KERNEL_IMAGE_NAME := Image
TARGET_FORCE_PREBUILT_KERNEL := true
TARGET_NO_KERNEL_OVERRIDE := true
TARGET_GENERATED_KERNEL_HEADERS := false

# Boot Image Headers & Offsets (AIK Derived)
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_OFFSET := 0x00008000
BOARD_RAMDISK_OFFSET := 0x01000000
BOARD_TAGS_OFFSET := 0x00000100
BOARD_DTB_OFFSET := 0x01f00000

# Kernel Prebuilts
BOARD_PREBUILT_BOOTIMAGE := $(KERNEL_PATH)/boot.img
BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbs/dtbo.img
BOARD_INCLUDE_DTB_IN_BOOTIMG := false # DTB is in vendor_boot for Header v4
BOARD_KERNEL_SEPARATED_DTBO := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false

# GKI & Modules
BOARD_RAMDISK_USE_LZ4 := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true

# GKI & Modules (Verified for 5.15.178)
BOARD_SYSTEM_KERNEL_MODULES_LOAD := $(KERNEL_PATH)/system_dlkm/lib/modules/5.15.178/modules.load
# BOARD_SYSTEM_KERNEL_MODULES_BLOCKLIST_FILE := $(KERNEL_PATH)/system_dlkm/lib/modules/5.15.178/modules.blocklist
BOARD_VENDOR_KERNEL_MODULES_LOAD := $(KERNEL_PATH)/vendor_dlkm/lib/modules/modules.load
# BOARD_VENDOR_KERNEL_MODULES_BLOCKLIST_FILE := $(KERNEL_PATH)/vendor_dlkm/lib/modules/modules.blocklist
BOARD_VENDOR_RAMDISK_KERNEL_MODULES_LOAD := $(KERNEL_PATH)/vendor_ramdisk/modules/modules.load
# BOARD_VENDOR_RAMDISK_KERNEL_MODULES_BLOCKLIST_FILE := $(KERNEL_PATH)/vendor_ramdisk/modules/modules.blocklist

# Cmdline & Bootconfig
BOARD_BOOTCONFIG := \
    androidboot.hardware=qcom \
    androidboot.memcg=1 \
    androidboot.usbcontroller=4e00000.dwc3

BOARD_KERNEL_CMDLINE := \
    console=ttyMSM0,115200n8 \
    earlycon=msm_geni_serial,0x04c8c000 \
    androidboot.console=ttyMSM0 \
    androidboot.selinux=permissive \
    kasan=off \
    disable_dma32=on \
    rcu_nocbs=all \
    rcutree.enable_rcu_lazy=1 \
    mtdoops.fingerprint=creek:13/OS3.0.10.0.WBOMIXM:user

# A/B & Metadata
AB_OTA_UPDATER := true
BOARD_USES_METADATA_PARTITION := true
BOARD_SUPER_PARTITION_METADATA_DEVICE := super
AB_OTA_PARTITIONS += \
    boot dtbo init_boot odm product system system_dlkm system_ext vbmeta vbmeta_system vendor vendor_boot vendor_dlkm

# Filesystem & EROFS Config
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
TARGET_USERIMAGES_USE_F2FS := true
BOARD_EROFS_PAGESIZE := 4096
BOARD_EROFS_PCLUSTER_SIZE := 262144
BOARD_EROFS_COMPRESSOR := lz4
BOARD_EROFS_COMMAND_LINE := -zlz4hc,9

# Dynamic Partitions
BOARD_SUPER_PARTITION_SIZE := 9126805504
BOARD_SUPER_PARTITION_GROUPS := qti_dynamic_partitions
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := odm product system system_dlkm system_ext vendor vendor_dlkm
BOARD_QTI_DYNAMIC_PARTITIONS_SIZE := 9122611200 

# Partition Sizes
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x06000000
BOARD_DTBOIMG_PARTITION_SIZE := 0x01800000
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 0x00800000
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 0x06000000
BOARD_FLASH_BLOCK_SIZE := 262144

# Security & Android Verified Boot
BOOT_SECURITY_PATCH := 2026-01-05
VENDOR_SECURITY_PATCH := $(BOOT_SECURITY_PATCH)
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := true
BOARD_AVB_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)

# VINTF & SKUs
DEVICE_MANIFEST_FILE := \
    $(DEVICE_PATH)/configs/vintf/manifest/manifest.xml \
    $(DEVICE_PATH)/configs/vintf/manifest/manifest_non_qmaa.xml
DEVICE_VINTF_COMPATIBILITY_MATRIX_FILE += $(DEVICE_PATH)/configs/vintf/manifest/compatibility_matrix.xml
ODM_MANIFEST_SKUS += o19ae

# Boot Control (UFS/BSG)
$(call soong_config_set, ufsbsg, ufsframework, bsg)

# QCOM Display (SM8450 / Bengal Family)
$(call soong_config_set, camera, override_format_from_reserved, true)
TARGET_USES_QCOM_DISPLAY_CUSTOM := true
TARGET_SCREEN_DENSITY := 320
TARGET_USES_GRALLOC4 := true
TARGET_USES_ION := true

# Gralloc & Graphics Logic
# This ensures the new source can talk to your older stock blobs
TARGET_USES_NEW_ION_API := true
TARGET_USES_COLOR_METADATA := true
TARGET_USES_DRM_PP := true

# SurfaceFlinger (Android 16 optimization)
# SM6225/Bengal needs this to prevent UI stuttering
TARGET_HAS_WIDE_COLOR_DISPLAY := true
TARGET_HAS_HDR_DISPLAY := true
TARGET_USE_NATIVE_IWC_DATASPACE := true

# Audio
AUDIO_FEATURE_ENABLED_DLKM := true
AUDIO_FEATURE_ENABLED_GEF_SUPPORT := true
AUDIO_FEATURE_ENABLED_HW_ACCELERATED_EFFECTS := true

# PAL & AGM (New Implementation)
AUDIO_FEATURE_ENABLED_AGM_HIDL := true
AUDIO_FEATURE_ENABLED_PAL_HIDL := true
AUDIO_FEATURE_ENABLED_LSM_HIDL := true
AUDIO_FEATURE_ENABLED_GKI_AUDIO := true
AUDIO_FEATURE_ENABLED_PAL := true

# Core Flags
TARGET_USES_QCOM_MM_AUDIO := true
TARGET_PROVIDES_AUDIO_HAL := true

# Multimedia (Required for Video/Audio Sync)
TARGET_USES_QCOM_MM_AUDIO := true
TARGET_USES_QCOM_DISPLAY_PP := true

# Connectivity
BOARD_WLAN_DEVICE := qcwcn
WIFI_DRIVER_DEFAULT := qca_cld3
WIFI_DRIVER_STATE_CTRL_PARAM := "/dev/wlan"
WPA_SUPPLICANT_VERSION := VER_0_8_X
TARGET_USES_NQ_NFC := true
ENABLE_VENDOR_RIL_SERVICE := true

# Sensors
TARGET_USES_QTI_SENSORS := true

# Power & Input
TARGET_POWERHAL_MODE_EXT := $(DEVICE_PATH)/power/power-mode.cpp
TARGET_TAP_TO_WAKE_NODE := "/proc/tp_gesture"

# Recovery / Fastbootd
BOARD_USES_RECOVERY_AS_BOOT := false
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/rootdir/etc/fstab.qcom
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888

# Init & SePolicy
$(call soong_config_set,libinit,vendor_init_lib,//$(DEVICE_PATH):init_creek)
include device/qcom/sepolicy_vndr/SEPolicy.mk
# include device/xiaomi/sepolicy/SEPolicy.mk
SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/private
BOARD_VENDOR_SEPOLICY_DIRS += $(DEVICE_PATH)/sepolicy/vendor

# Global LTO & Optimization
TARGET_GLOBAL_THINLTO := true
HWUI_COMPILE_FOR_PERF := true

# Hardware Features
TARGET_PD_SERVICE_ENABLED := true
TARGET_PER_MGR_ENABLED := true

# Properties
TARGET_ODM_PROP += $(DEVICE_PATH)/configs/properties/odm.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/configs/properties/product.prop
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/configs/properties/system.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/configs/properties/system_ext.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/configs/properties/vendor.prop

# Partition Reserved Size
-include vendor/lineage/config/BoardConfigReservedSize.mk
