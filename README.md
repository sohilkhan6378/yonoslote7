# RummyPro

A production-grade, multi-game Rummy platform built with Flutter, GetX, and Firebase. The project showcases a real-money wallet flow, pluggable game engine architecture, and admin tooling for compliance-driven operations.

> **Disclaimer:** “इस ऐप में कैश गेम्स 18+ यूज़र्स के लिए हैं। अपने क्षेत्र के क़ानून जाँच लें. जिम्मेदारी से खेलें—डिपॉज़िट लिमिट, रियलिटी चेक और सेल्फ-एक्सक्लूज़न सेटिंग्स उपलब्ध हैं।”

## Table of Contents
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [Firebase Setup](#firebase-setup)
- [Remote Config Defaults](#remote-config-defaults)
- [Running the App](#running-the-app)
- [Cloud Functions](#cloud-functions)
- [Firestore & Storage Rules](#firestore--storage-rules)
- [Admin User Creation](#admin-user-creation)
- [Testing](#testing)
- [Common Issues](#common-issues)
- [Legal & Compliance](#legal--compliance)

## Prerequisites
- Flutter (stable) >= 3.22
- Dart >= 3.3
- Firebase CLI >= 12
- Node.js >= 18 (for Cloud Functions)
- Git, VS Code/Android Studio
- Xcode for iOS builds, Android SDK for Android builds

## Project Structure
```
lib/
  app.dart
  main.dart
  main_dev.dart
  main_staging.dart
  main_prod.dart
  core/
  data/
  domain/
  presentation/
  config/
  firebase_options.dart
assets/
functions/
docs/
```
Refer to [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) for detailed layer and sequence diagrams.

## Firebase Setup
1. Create a Firebase project and enable Android, iOS, and optionally Web apps.
2. Install FlutterFire CLI: `dart pub global activate flutterfire_cli`.
3. Run `flutterfire configure` and place the generated `firebase_options.dart` under `lib/`.
4. Enable Firebase Auth (Email/Password, Phone if desired), Firestore, Storage, Analytics, Remote Config, and Crashlytics.
5. Initialize Firestore and Storage with the provided rules.
6. Configure Firebase Hosting if you plan to ship the web client (optional).

### Authentication Providers
- Email + Password (mandatory)
- Phone OTP (optional, flagged by Remote Config)

## Remote Config Defaults
A sample configuration is available at [`remote_config_defaults.json`](remote_config_defaults.json). Upload via Firebase Console or CLI:
```bash
firebase remoteconfig versions:list
firebase remoteconfig:versions:update --update-from-file remote_config_defaults.json
```
Key toggles include rake percentage, region allow/deny lists, and responsible gaming feature flags.

## Running the App
The project uses flavors. Supply environment variables through `--dart-define`.

```bash
flutter pub get
flutter run -t lib/main_dev.dart --dart-define=FLAVOR=dev --dart-define=RZP_KEY=rzp_test --dart-define=ALLOWED_REGIONS=IN
```
Repeat with `main_staging.dart` and `main_prod.dart` for other environments. Ensure you have valid bundle identifiers and provisioning profiles for iOS builds.

## Cloud Functions
Navigate to the `functions` directory, install dependencies, and deploy:
```bash
cd functions
npm install
npm run lint
firebase deploy --only functions
```
Functions include deposit/withdrawal flows, round dealing/settlement, and admin utilities. See [`functions/README.md`](functions/README.md) for details.

## Firestore & Storage Rules
Security rules are provided in [`firestore.rules`](firestore.rules) and [`storage.rules`](storage.rules). Deploy via:
```bash
firebase deploy --only firestore:rules
firebase deploy --only storage:rules
```

## Admin User Creation
Use the Cloud Function `setCustomClaimAdmin` to mark a Firebase Auth user as admin:
```bash
firebase functions:shell
setCustomClaimAdmin({ uid: "USER_UID" })
```
Admin users gain access to KYC approvals, wallet adjustments, table management, and reporting.

## Testing
Run unit, widget, and golden tests:
```bash
flutter test
```
For targeted suites:
```bash
flutter test test/unit
flutter test test/widget
```
Coverage commands are documented in [`docs/TESTING.md`](docs/TESTING.md).

## Common Issues
| Issue | Resolution |
|-------|------------|
| Firebase initialization fails | Verify `firebase_options.dart` matches the running flavor. |
| Payment mocks not responding | Ensure mock provider is enabled via Remote Config or `--dart-define`. |
| Cloud Functions deployment errors | Run `npm install` and confirm Node.js version >= 18. |
| KYC uploads rejected | Confirm Storage rules and bucket path match the instructions. |

## Legal & Compliance
For regulatory guidance, age-gating, and responsible gaming policies review [`docs/COMPLIANCE.md`](docs/COMPLIANCE.md).

---
Maintained by the RummyPro architecture team.
