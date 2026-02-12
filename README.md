# nfcyes

**Modern NFC Tag Reader**

Lightweight Flutter app to scan NFC/RFID tags on Android and show the tag payload as JSON.

![Version](https://img.shields.io/badge/version-1.0.0%2B1-blue)
![Flutter](https://img.shields.io/badge/Flutter-3.38.5-02569B?logo=flutter)
![License](https://img.shields.io/badge/license-MIT-green)

## What it does
- Detects NFC availability on the phone.
- Listens for NFC tags and prints the raw tag data as JSON.

## What it does NOT do
- Cannot clone or emulate bank/payment cards.
- Host Card Emulation only works for your own AID; it cannot mimic secure cards.
- Phones cannot read many non-NFC RFID cards (e.g., 125 kHz systems).

## Requirements
- Android SDK installed; set `ANDROID_HOME` (example: `C:\Users\<user>\AppData\Local\Android\Sdk`).
- Flutter 3.38.5+; run `flutter --version` to confirm.
- An Android device with NFC turned on.




## Features

### 🔍 NFC Scanning
- Detects device NFC availability and readiness
- Scans common tag types (NFC-A/B/F/V, ISO-DEP, NDEF, MiFare where supported by the device)
- Shows raw tag data as JSON for quick inspection
- Cancel scanning sessions at any time

### 📝 Session Details
- Simple live status (listening/idle)
- Surfaces basic tag metadata (tech list, ID in hex)

### 🎨 UX
- Minimal, fast demo UI focused on NFC feedback
- Snackbar-style notices for scan state and errors

## Technology Stack
- **Flutter** (3.38.5) — UI framework
- **nfc_manager** — NFC/RFID tag access on Android

## Project Structure

```
lib/
└── main.dart               # App entry point and NFC handling
```

## Setup & Installation

1) Install dependencies
```powershell
flutter pub get
```

2) Run the app (device/emulator with NFC)
```powershell
flutter run
```

## Build Release APK
```powershell
flutter build apk
```

## Platform Requirements
- Android SDK installed; set `ANDROID_HOME` (e.g. `C:\Users\<user>\AppData\Local\Android\Sdk`)
- Android device with NFC hardware enabled

## Usage
1. Launch the app; it checks NFC availability.
2. Tap to start scanning and place a tag near the device.
3. View raw tag data shown as JSON.
4. Stop scanning when finished.

## Limitations
- Does **not** clone/emulate bank or payment cards.
- Host Card Emulation is not included; only tag reading is implemented.
- Many low-frequency RFID cards (e.g., 125 kHz) are not readable by phones.

## Development
- Flutter 3.38.5 • Dart 3.10.4 • channel stable

## License

MIT License. See `LICENSE` for details.
