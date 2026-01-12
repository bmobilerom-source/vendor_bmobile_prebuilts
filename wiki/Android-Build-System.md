# Android Build System Configuration

This guide explains how to configure prebuilt apps in the Android build system for the Bmobile vendor prebuilts.

## Overview

The Android build system uses two main configuration files:
- `Android.bp` - Soong build system (modern, preferred)
- `config.mk` - Make build system (legacy, for compatibility)

## Android.bp Configuration

### Module Definition

Each prebuilt app is defined using the `android_app_import` module type:

```bp
android_app_import {
    name: "AppName",
    apk: "path/to/app.apk",
    presigned: true,
    dex_preopt: {
        enabled: false,
    },
    product_specific: true,
    privileged: false,
}
```

### Parameters Explained

| Parameter | Description | Example |
|-----------|-------------|---------|
| `name` | Module name used in PRODUCT_PACKAGES | `"AmbientMusic"` |
| `apk` | Path to the APK file | `"amusic/Ambient-Music-v3.3.2.apk"` |
| `presigned` | Whether APK is already signed | `true` |
| `dex_preopt.enabled` | Enable/disable DEX preoptimization | `false` |
| `product_specific` | Install in product partition | `true` |
| `privileged` | System privileged app | `false` |

## config.mk Configuration

### Modern Approach

For modern Android builds, use PRODUCT_PACKAGES declaration:

```mk
# Add namespace
PRODUCT_SOONG_NAMESPACES += vendor/bmobile/prebuilts

# Declare packages
PRODUCT_PACKAGES += \
    AmbientMusic \
    CalculatorYou \
    FossifyContacts
```

### Legacy Make Approach (Deprecated)

The old Make-based approach is deprecated but shown for reference:

```mk
LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := AppName
LOCAL_MODULE_CLASS := APPS
LOCAL_MODULE_TAGS := optional
LOCAL_CERTIFICATE := PRESIGNED
LOCAL_SRC_FILES := path/to/app.apk
LOCAL_MODULE_PATH := $(TARGET_OUT_VENDOR)/prebuilts
include $(BUILD_PREBUILT)
```

## Build Integration

### Adding to Device Makefile

To include these apps in your device build, add to your device makefile:

```mk
# Include Bmobile prebuilts
$(call inherit-product-if-exists, vendor/bmobile/prebuilts/config.mk)
```

### Verifying Build

After building, verify apps are installed:

```bash
# Check if apps are in system
adb shell pm list packages | grep -E "(ambient|calculator|fossify)"

# Check installation paths
adb shell ls /product/prebuilts/app/
```

## Troubleshooting

### Common Issues

1. **Build fails with "module not found"**
   - Check PRODUCT_PACKAGES names match Android.bp names
   - Verify namespace is added to PRODUCT_SOONG_NAMESPACES

2. **App not installed**
   - Check product_specific setting
   - Verify APK path is correct

3. **Permission denied**
   - Ensure APK is properly signed
   - Check privileged setting if needed

### Debug Commands

```bash
# List all modules
make moduleshow <ModuleName>

# Check build variables
make dumpvar-PRODUCT_PACKAGES

# Clean and rebuild
make clean-<ModuleName>
```