#
# Copyright (C) 2026 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from sony sm8550-common
$(call inherit-product, device/xiaomi/sm6225-common/common.mk)

# Android 16 Build Environment
SOONG_ALLOW_MISSING_DEPENDENCIES := true
BOARD_SHIPPING_API_LEVEL := 35

# Broken Rules (Required for blob compatibility)
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_INCORRECT_PARTITION_IMAGES := true
BOARD_HAS_REMOVABLE_STORAGE := true
BUILD_BROKEN_VINTF_PRODUCT_COPY_FILES := true
BUILD_BROKEN_PREBUILT_UI_HAL := true
BUILD_BROKEN_MISSING_PGO_STATS := true

TARGET_BOARD_SUFFIX := _515

# VINTF & SKUs
DEVICE_MANIFEST_FILE := \
    $(DEVICE_PATH)/configs/vintf/manifest/manifest.xml \
    $(DEVICE_PATH)/configs/vintf/manifest/manifest_non_qmaa.xml
DEVICE_VINTF_COMPATIBILITY_MATRIX_FILE += $(DEVICE_PATH)/configs/vintf/manifest/compatibility_matrix.xml
ODM_MANIFEST_SKUS += o19ae

# Boot Control (UFS/BSG)
$(call soong_config_set, ufsbsg, ufsframework, bsg)

# QCOM Display (Bengal Family)
TARGET_SCREEN_DENSITY := 320
TARGET_USES_GRALLOC4 := true
TARGET_USES_ION := true
TARGET_USES_QTI_MAPPER_2_0 := true
TARGET_USES_QTI_MAPPER_EXT_1_1 := true

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

# Multimedia (Required for Video/Audio Sync)
TARGET_USES_QCOM_MM_AUDIO := true
TARGET_USES_QCOM_DISPLAY_PP := true

# Sensors
TARGET_USES_QTI_SENSORS := true

# Power & Input
TARGET_POWERHAL_MODE_EXT := $(DEVICE_PATH)/power/power-mode.cpp
TARGET_TAP_TO_WAKE_NODE := "/proc/tp_gesture"

# Global LTO & Optimization
TARGET_GLOBAL_THINLTO := true
BOARD_GLOBAL_LTO_CPPFLAGS := -O3
HWUI_COMPILE_FOR_PERF := true

# Hardware Features
TARGET_PD_SERVICE_ENABLED := true
TARGET_PER_MGR_ENABLED := true