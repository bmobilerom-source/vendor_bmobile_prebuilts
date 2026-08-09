# Reef

> **Unpackaged:** `App.onCreate` reads CE SharedPreferences before user unlock → crash → RescueParty before Setup Wizard. Do not re-add to `PRODUCT_PACKAGES` until a direct-boot-safe APK is ready.
>
> KidsSafe wellbeing replacement: **[DigiPaws](Digipaws.md)**. Postmortem: [errors/reef-ce-prefs-rescueparty.md](../../../errors/reef-ce-prefs-rescueparty.md). Research: [errors/reef-alternative-wellbeing-research.md](../../../errors/reef-alternative-wellbeing-research.md).

## Description

Reef is an open-source screen-time / focus app (blockers, routines, Pomodoro, usage stats). MIT licensed. Upstream: https://github.com/aload0/Reef

## Version

4.3.0 (`v4.3.0`)

## Package Details

- APK File: `Reef-release-4.3.0.apk`
- Module Name: `Reef`
- Package: `dev.pranav.reef`
- Launcher: `dev.pranav.reef.MainActivity`
- Build Type: Prebuilt APK import
- SHA256: `7a075dfbafcda73532875bfee1e0b07b30252d8910a0b5f0048b791a16a4e12e`

## Build Configuration

- Presigned: true
- Dex Preopt: Disabled
- Product Specific: true
- Privileged: false
- **In `PRODUCT_PACKAGES`:** no (commented in `config.mk`)

## Purpose

Formerly KidsSafe screen-time / focus. Superseded for shipping by DigiPaws until Reef is CE-safe. Settings still has `ReefController` for optional sideload experiments.

## Attribution

Copyright and MIT license terms of aload0/Reef / Pranav Purwar apply. Mandatory attribution per upstream README.
