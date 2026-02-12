# nfcyes

Flutter app for scanning NFC tags on Android.

## Status
- App version: `1.0.0+1`
- Tested Flutter: `3.38.5` (Dart `3.10.4`, channel `stable`)

## What this app does
- Scans NFC tags and displays raw tag data as JSON.
- Shows NFC availability and basic session state.

## Important limitations (read first)
- **No payment card cloning or wallet emulation.** Android/Flutter apps cannot emulate bank cards or payment tokens.
- **HCE is limited.** Android Host Card Emulation (HCE) only works for your own AID and protocol; it cannot impersonate existing secure cards.
- **RFID != NFC.** Many RFID cards (125kHz, 13.56MHz with proprietary protocols) cannot be read by phones.

If you need true card emulation for a custom system, we can add a native Android HCE module and pair it with your backend and reader hardware. Tell me your reader protocol and AID.

## Prerequisites
- Android SDK installed and `ANDROID_HOME` set (e.g. `C:\Users\<user>\AppData\Local\Android\Sdk`).
- Flutter SDK 3.38.5+ with matching Dart (see `flutter --version`).
- Android device with NFC enabled.

## Setup
```powershell
flutter pub get
```

## Run
```powershell
flutter run
```

## Build APK
```powershell
flutter build apk
```

## Notes
- Uses the `nfc_manager` plugin for tag discovery on Android.
- Ensure NFC is enabled in device settings.
