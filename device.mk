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

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# Inherit from Qualcomm common and storage definitions
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Dalvik VM configs for 6GB RAM
$(call inherit-product, frameworks/native/build/phone-xhdpi-6144-dalvik-heap.mk)

# A/B Partition Post-install
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=erofs \
    POSTINSTALL_OPTIONAL_vendor=true

# Audio - PAL/AGM Architecture (SM6225)
$(call soong_config_set, android_hardware_audio, run_64bit, true)

PRODUCT_PACKAGES += \
    android.hardware.audio.service \
    audio.primary.bengal \
    android.hardware.graphics.composer@2.1-service \
    android.hardware.graphics.allocator@4.0-service \
    android.hardware.camera.provider@2.4-service \
    android.hardware.gnss@1.0-service \
    libdisplayconfig.qti \
    vendor.qti.hardware.display.mapper@4.0.vendor \
    libgui_vendor \
    libgralloctypes \
    libar-pal \
    libagm \
    libagmclient \
    vendor.qti.hardware.pal@1.0.vendor \
    vendor.qti.hardware.AGMIPC@1.0.vendor \
    adsprpcd \
    cdsprpcd \
    audioadsprpcd

# PRODUCT_COPY_FILES += \
#     $(DEVICE_PATH)/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
#     $(DEVICE_PATH)/audio/audio_effects.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.xml \
#     $(DEVICE_PATH)/audio/mixer_paths_bengal_idp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths_bengal_idp.xml \
#     $(DEVICE_PATH)/audio/resourcemanager_bengal_idp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/resourcemanager_bengal_idp.xml

# Camera & Display
# PRODUCT_PACKAGES += \
#     vendor.qti.hardware.camera.postproc@1.0.vendor \
#     displayfeature \
#     vendor.xiaomi.hardware.displayfeature@1.0.vendor \
#     vendor.display.color@1.0-service

# PRODUCT_PROPERTY_OVERRIDES += \
#     ro.surface_flinger.game_default_frame_rate_override=120 \
#     ro.surface_flinger.set_idle_timer_ms=4000

# Fingerprint & Input
# PRODUCT_PACKAGES += \
#     android.hardware.biometrics.fingerprint-service.xiaomi \
#     vendor.xiaomi.hw.touchfeature@1.0-service

# NFC (Creek SKU Fix: o19ae)
# PRODUCT_COPY_FILES += \
#     frameworks/native/data/etc/android.hardware.nfc.hce.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_o19ae/android.hardware.nfc.hce.xml \
#     frameworks/native/data/etc/android.hardware.nfc.xml:$(TARGET_COPY_OUT_ODM)/etc/permissions/sku_o19ae/android.hardware.nfc.xml

# Xiaomi Services & Thermal
# PRODUCT_PACKAGES += \
#     mi_thermald \
#     batterysecret \
#     vendor.xiaomi.hardware.misys@4.0.vendor

# Overlays
# PRODUCT_PACKAGES += \
#     FrameworksResCreek

# DEVICE_PACKAGE_OVERLAYS += \
#     $(LOCAL_PATH)/overlay-lineage

# WiFi Symlinks
PRODUCT_PACKAGES += \
    firmware_wlan_mac.bin_symlink \
    firmware_WCNSS_qcom_cfg.ini_symlink \
    firmware_wlanmdsp.mbn_symlink

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Inherit from the proprietary vendor version
$(call inherit-product, vendor/xiaomi/creek/creek-vendor.mk)
