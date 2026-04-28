#
# Minimal Boot Test BoardConfig (Creek)
#


DEVICE_PATH := device/xiaomi/creek
KERNEL_PATH := $(DEVICE_PATH)-kernel

# Primary Architecture (64-bit)
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a

# Secondary Architecture (32-bit)
TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi

# Platform
TARGET_BOARD_PLATFORM := bengal
TARGET_BOOTLOADER_BOARD_NAME := bengal

# Kernel (PREBUILT TEST)
TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/kernel
TARGET_FORCE_PREBUILT_KERNEL := true

BOARD_KERNEL_IMAGE_NAME := Image

BOARD_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)

BOARD_RAMDISK_USE_LZ4 := true

# Boot Image Sizes (safe defaults)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864

BOARD_FLASH_BLOCK_SIZE := 262144

# Basic kernel cmdline (keep minimal)
BOARD_KERNEL_CMDLINE := \
    console=ttyMSM0,115200n8 \
    androidboot.hardware=qcom \
    androidboot.selinux=permissive

BOARD_BOOTCONFIG := \
    androidboot.hardware=qcom

# DTB / DTBO (PREBUILT ONLY)
BOARD_USES_DT := true
BOARD_KERNEL_SEPARATED_DTBO := true

BOARD_PREBUILT_DTBOIMAGE := $(KERNEL_PATH)/dtbs/dtbo.img
BOARD_PREBUILT_DTBIMAGE_FILE := $(KERNEL_PATH)/dtbs/dtb.img

TARGET_PREBUILT_KERNEL := $(KERNEL_PATH)/kernel

# Boot image format
BOARD_INCLUDE_DTB_IN_BOOTIMG := false
BOARD_INCLUDE_DTB_IN_VENDOR_BOOT := true

# Remove ALL system/vendor complexity
SOONG_ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true