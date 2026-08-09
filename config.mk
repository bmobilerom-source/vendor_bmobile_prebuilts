# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    vendor/bmobile/prebuilts

# Prebuilt apps
# DigiPaws: KidsSafe screen-time / wellness (simpler than Zenith; replaces Reef).
# Reef NOT packaged: App.onCreate touches CE SharedPreferences before user unlock
# → FATAL → RescueParty warm-reboot before Setup Wizard. Re-add only with a
# direct-boot-safe APK. See errors/reef-ce-prefs-rescueparty.md.
PRODUCT_PACKAGES += \
    AmbientMusic \
    CalculatorYou \
    FossifyContacts \
    PhotoWidget \
    SpeakThat \
    SystemAthena \
    Zenith \
    Digipaws \
    Braincup \
    FMD \
    Sunup \
    LocalNLPBackend \
    Snes9xEXPlus
#    Reef \
