# Bmobile Vendor Prebuilts

This repository contains prebuilt Android applications for the Bmobile vendor build. These apps are included as prebuilt APKs in the Android build system.

## 📁 Structure

```
vendor_bmobile_prebuilts/
├── Android.bp           # Soong build system configuration
├── config.mk           # Product package declarations
├── wiki/               # Documentation
│   ├── Home.md        # Main documentation index
│   ├── _Sidebar.md    # Navigation sidebar
│   ├── Android-Build-System.md
│   ├── Build-Integration.md
│   ├── Adding-New-Apps.md
│   └── [App].md       # Individual app documentation
├── amusic/            # Ambient Music app
├── calculator/        # CalculatorYou app
├── contacts/          # Fossify Contacts app
├── digipaws/          # DigiPaws KidsSafe wellness (in PRODUCT_PACKAGES)
├── reef/              # Reef (APK retained; NOT in PRODUCT_PACKAGES — CE RescueParty)
├── launchpad/         # Launchpad app
├── photo/             # Photo Widget app
├── speakthat/         # SpeakThat app
└── systemAthena/      # System Athena app
└── zenith/            # Zenith app
```

## 📚 Documentation

📖 **[Full Documentation](wiki/Home.md)** - Complete wiki with tutorials and guides

### Quick Start
- **[Build Integration](wiki/Build-Integration.md)** - How to include in your ROM
- **[Adding New Apps](wiki/Adding-New-Apps.md)** - Tutorial for new prebuilts
- **[Android Build System](wiki/Android-Build-System.md)** - Configuration reference

## 📱 Included Apps

| App | Version | Category | Description |
|-----|---------|----------|-------------|
| Ambient Music | v3.3.2 | Multimedia | Ambient music player |
| CalculatorYou | v3.1.2 | Utilities | Advanced calculator |
| Fossify Contacts | v9 | Productivity | Privacy-focused contacts manager |
| Digipaws | v23 | Wellness | KidsSafe screen time / wellness (simpler than Zenith) |
| Reef | v4.3.0 | Wellness | Unpackaged — CE prefs RescueParty; APK retained |
| Launchpad | v764 | Utilities | App launcher |
| Photo Widget | v1.32.3 | Multimedia | Photo display widget |
| SpeakThat | N/A | Utilities | Text-to-speech utility |
| System Athena | N/A | System | System information tool |
| Zenith | v1.5.2 | Wellness | App shielding / mindful usage ([upstream](https://github.com/1372Slash/Zenith)) |

## 🔧 Build Integration

### LineageOS/Custom ROMs

Add to your device makefile:

```mk
# Include Bmobile prebuilts
$(call inherit-product-if-exists, vendor/bmobile/prebuilts/config.mk)
```

### Manual Integration

```mk
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
# Reef unpackaged — see wiki/Reef.md
```

## 🚀 Build Commands

```bash
# Clean build
make clean

# Build with prebuilts
make -j$(nproc)

# Verify installation
adb shell pm list packages | grep -E "(ambient|calculator|fossify)"
```

## 📝 Contributing

1. Follow the [Adding New Apps](wiki/Adding-New-Apps.md) tutorial
2. Update documentation in the `wiki/` folder
3. Test changes in a build
4. Submit pull request

## 📄 License

See [LICENSE](LICENSE) file for details.

---

*Maintained by Bmobile Team | Last updated: January 2026*

