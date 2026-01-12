# Adding New Prebuilt Apps

This tutorial guides you through adding new prebuilt applications to the Bmobile vendor prebuilts.

## Prerequisites

- APK file of the application to add
- Basic understanding of Android build system
- Access to build environment

## Step 1: Prepare the APK

### Directory Structure

Create a directory for your new app:

```bash
mkdir your_app_name
```

Place the APK file in the new directory:

```
vendor_bmobile_prebuilts/
├── your_app_name/
│   └── YourApp-v1.0.0.apk
├── Android.bp
├── config.mk
└── wiki/
```

### APK Requirements

- **Signed**: APK must be signed (use `presigned: true`)
- **Compatible**: Target API level should match your ROM
- **Clean**: No malware or unwanted permissions
- **Tested**: Verify app works on target device

## Step 2: Update Android.bp

Add a new `android_app_import` module to the Android.bp file:

```bp
android_app_import {
    name: "YourApp",
    apk: "your_app_name/YourApp-v1.0.0.apk",
    presigned: true,
    dex_preopt: {
        enabled: false,
    },
    product_specific: true,
    privileged: false,
}
```

### Configuration Options

Choose appropriate settings based on app requirements:

- **privileged: true** - For system apps needing special permissions
- **product_specific: false** - For system apps in /system partition
- **dex_preopt.enabled: true** - For performance-critical apps

## Step 3: Update config.mk

Add the new app to the PRODUCT_PACKAGES list:

```mk
PRODUCT_PACKAGES += \
    AmbientMusic \
    CalculatorYou \
    YourApp \        # <-- Add here
    FossifyContacts
```

## Step 4: Create Documentation

### App Documentation

Create a documentation file in the wiki folder:

```bash
touch wiki/Your-App.md
```

Use this template:

```markdown
# Your App Name

## Description
Brief description of what the app does.

## Version
v1.0.0

## Package Details
- APK File: `your_app_name/YourApp-v1.0.0.apk`
- Module Name: `YourApp`
- Build Type: Prebuilt APK import

## Build Configuration
- Presigned: true
- Dex Preopt: Disabled
- Product Specific: true
- Privileged: false

## Purpose
Why this app is included in Bmobile prebuilts.
```

### Update Home.md

Add the new app to the overview table in `wiki/Home.md`:

```markdown
| [Your App](Your-App.md) | v1.0.0 | Category | Description |
```

## Step 5: Test the Build

### Build Commands

```bash
# Clean previous build
make clean

# Build with new app
make -j$(nproc)

# Or build specific module
make YourApp
```

### Verify Installation

```bash
# Flash build and check
adb shell pm list packages | grep yourapp

# Check app info
adb shell dumpsys package your.app.package.name
```

## Step 6: Handle Special Cases

### Privileged Apps

For system apps needing elevated permissions:

```bp
android_app_import {
    name: "SystemApp",
    apk: "system_app/SystemApp.apk",
    presigned: true,
    dex_preopt: {
        enabled: false,
    },
    product_specific: false,  # Install in /system
    privileged: true,         # System privileged app
}
```

### Large APKs

For large applications, consider:

```bp
android_app_import {
    name: "LargeApp",
    apk: "large_app/LargeApp.apk",
    presigned: true,
    dex_preopt: {
        enabled: false,  # Disable to save space
    },
    product_specific: true,
    privileged: false,
}
```

## Step 7: Update Version Control

### Commit Changes

```bash
git add .
git commit -m "Add YourApp v1.0.0 to prebuilts

- Add YourApp APK and configuration
- Update build files
- Add documentation

Change-Id: I1234567890abcdef"
```

## Troubleshooting

### Build Errors

**"Module not found"**
- Check PRODUCT_PACKAGES name matches Android.bp name
- Verify namespace in PRODUCT_SOONG_NAMESPACES

**"Permission denied"**
- Ensure APK is properly signed
- Check privileged setting

**"Out of space"**
- Consider disabling dex_preopt
- Use product_specific: true for /product partition

### Runtime Issues

**App crashes on launch**
- Verify APK compatibility with target Android version
- Check required permissions are granted

**App not appearing in launcher**
- Verify installation path
- Check if app declares launcher intent

## Best Practices

- Always test apps on target device before committing
- Keep documentation up-to-date
- Use descriptive module names
- Follow existing naming conventions
- Test builds after changes
- Document any special configuration requirements