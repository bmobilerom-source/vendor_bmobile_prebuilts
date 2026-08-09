# Digipaws

## Description

DigiPaws is a digital wellness and parental-oriented screen-time app for Android. BMobile uses it as the **KidsSafe** wellbeing / usage-info app (simpler than Zenith; replaces Reef while Reef remains unpackaged).

## Version

23 (`2.3-alpha-lite`)

## Package Details

- APK File: `nethical.digipaws_23.apk`
- Module Name: `Digipaws`
- Package: `nethical.digipaws`
- Launcher: `nethical.digipaws.ui.activity.MainActivity`
- Build Type: Prebuilt APK import
- SHA256: `d3ec35d3a05fa51635698937e134e801e5d06b33d5b18f7245c9c6d46abe806b`

## Build Configuration

- Presigned: true
- Preprocessed: true
- Dex Preopt: Disabled
- Product Specific: true
- Privileged: false
- **In `PRODUCT_PACKAGES`:** yes (`config.mk`)

## Purpose

KidsSafe screen time / digital wellness for young users. Shows usage-style info with a simpler UI than Zenith. Settings launch helper: `DigipawsController`.

**Hidden from the home launcher** (Trebuchet `filtered_components` + `hide_applist` + Game Zone always-hidden). Still openable via Settings / explicit intent.

## Upstream note

Upstream [nethical6/digipaws](https://github.com/nethical6/digipaws) is discontinued in favor of [Curbox](https://github.com/curbox-app/curbox-android). BMobile keeps v23 for simplicity. See [errors/reef-alternative-wellbeing-research.md](../../../errors/reef-alternative-wellbeing-research.md).

## Status

**Active** KidsSafe wellbeing package. Reef remains unpackaged ([Reef.md](Reef.md), [errors/reef-ce-prefs-rescueparty.md](../../../errors/reef-ce-prefs-rescueparty.md)).
