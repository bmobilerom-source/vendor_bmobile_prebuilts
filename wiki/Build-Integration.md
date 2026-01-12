# Build Integration Guide

This guide explains how to integrate Bmobile prebuilt apps into your Android ROM build system.

## Supported Build Systems

### LineageOS 18.1+ (Recommended)

For modern LineageOS builds:

```mk
# In your device makefile (device/manufacturer/device/device.mk)

# Include Bmobile prebuilts
$(call inherit-product-if-exists, vendor/bmobile/prebuilts/config.mk)
```

### Custom ROMs

For other custom ROMs:

```mk
# In your device makefile

# Add namespace
PRODUCT_SOONG_NAMESPACES += vendor/bmobile/prebuilts

# Include packages
PRODUCT_PACKAGES += \
    AmbientMusic \
    CalculatorYou \
    FossifyContacts \
    Digipaws \
    Launchpad \
    PhotoWidget \
    SpeakThat \
    SystemAthena
```

## Directory Structure

Ensure your vendor directory structure matches:

```
vendor/
├── bmobile/
│   └── prebuilts/
│       ├── Android.bp           # Module definitions
│       ├── config.mk           # Package declarations
│       ├── amusic/
│       │   └── Ambient-Music-v3.3.2.apk
│       ├── calculator/
│       │   └── CalculatorYou-v3.1.2.apk
│       └── ...
```

## Build Commands

### Full Build

```bash
# Clean build
make clean

# Build with all prebuilts
make -j$(nproc) 2>&1 | tee build.log
```

### Incremental Build

```bash
# Build only prebuilt apps
make AmbientMusic CalculatorYou FossifyContacts

# Or build all PRODUCT_PACKAGES
make systemimage
```

### Debug Build

```bash
# Enable verbose output
make showcommands

# Check specific module
make dumpvar-PRODUCT_PACKAGES

# List available modules
make modules
```

## Verification Steps

### Post-Build Checks

1. **Verify APK installation:**
```bash
# After flashing ROM
adb shell pm list packages | grep -E "(ambient|calculator|fossify)"
```

2. **Check file locations:**
```bash
adb shell ls -la /product/prebuilts/app/
adb shell ls -la /system/priv-app/  # For privileged apps
```

3. **Verify app functionality:**
```bash
# Launch apps and test basic features
adb shell am start -n com.package.name/.MainActivity
```

### Build Log Analysis

```bash
# Check for prebuilt-related errors
grep -i "prebuilt\|bmobile" build.log

# Verify modules were processed
grep -i "AmbientMusic\|CalculatorYou" build.log
```

## Common Integration Issues

### Missing Dependencies

**Error:** `module not found in product packages`

**Solution:**
```mk
# Ensure namespace is added
PRODUCT_SOONG_NAMESPACES += vendor/bmobile/prebuilts
```

### Path Issues

**Error:** `No such file or directory`

**Solution:**
- Verify APK paths in Android.bp are correct
- Check directory permissions
- Ensure symlinks are properly set up

### Permission Issues

**Error:** `Permission denied`

**Solutions:**
- Check APK signature
- Verify privileged app settings
- Ensure correct SELinux policies

### Storage Issues

**Error:** `No space left on device`

**Solutions:**
- Disable dex preoptimization: `dex_preopt.enabled: false`
- Use product partition: `product_specific: true`
- Remove unnecessary apps from PRODUCT_PACKAGES

## Advanced Configuration

### Conditional Inclusion

Include apps only for specific variants:

```mk
# In device makefile
ifeq ($(TARGET_BUILD_VARIANT),user)
    PRODUCT_PACKAGES += AmbientMusic CalculatorYou
endif

ifneq ($(TARGET_BUILD_VARIANT),user)
    PRODUCT_PACKAGES += FossifyContacts Digipaws
endif
```

### Custom Installation Paths

Override default installation locations:

```bp
android_app_import {
    name: "CustomApp",
    apk: "custom_app/CustomApp.apk",
    presigned: true,
    dex_preopt: {
        enabled: false,
    },
    product_specific: true,
    privileged: false,
    # Custom properties
    overrides: ["OldApp"],
    install_in_data: false,
}
```

### Multiple Variants

Support different APK variants:

```bp
// Release version
android_app_import {
    name: "MyApp",
    apk: "myapp/MyApp-release.apk",
    presigned: true,
    // ... other config
}

// Debug version
android_app_import {
    name: "MyAppDebug",
    apk: "myapp/MyApp-debug.apk",
    presigned: true,
    // ... other config
}
```

## Performance Optimization

### DEX Preoptimization

For performance-critical apps:

```bp
android_app_import {
    name: "PerformanceApp",
    apk: "performance_app/PerformanceApp.apk",
    presigned: true,
    dex_preopt: {
        enabled: true,
        app_image: true,
        profile_guided: true,
    },
    product_specific: true,
    privileged: false,
}
```

### Compression

Reduce APK size impact:

```bp
android_app_import {
    name: "LargeApp",
    apk: "large_app/LargeApp.apk",
    presigned: true,
    dex_preopt: {
        enabled: false,  // Save space
    },
    product_specific: true,
    compressed: "gz",    // Enable compression
    privileged: false,
}
```

## Testing Strategy

### Automated Testing

```bash
# Build test
make droid

# Install test
adb install-multiple *.apk

# Runtime test
adb shell monkey -p com.package.name -v 1000
```

### Manual Testing

1. Install ROM on test device
2. Verify all apps appear in launcher
3. Test basic functionality of each app
4. Check for crashes or permission issues
5. Verify system stability

## Maintenance

### Updating Apps

1. Download new APK version
2. Update Android.bp with new path
3. Update documentation
4. Test build and functionality
5. Commit changes

### Removing Apps

1. Remove from PRODUCT_PACKAGES in config.mk
2. Optionally remove Android.bp entry
3. Remove APK files
4. Update documentation
5. Clean build

### Monitoring

```bash
# Monitor app performance
adb shell dumpsys cpuinfo | grep -A5 -B5 yourapp

# Check app health
adb shell ps | grep yourapp

# Log analysis
adb logcat | grep -i yourapp
```