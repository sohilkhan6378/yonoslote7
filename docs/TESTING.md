# Testing Guide

## Unit Tests
- Located under `test/unit/`.
- Run `flutter test test/unit`.
- Key suites: `rummy_engine_test.dart`, `wallet_repository_test.dart`.

## Widget Tests
- Located under `test/widget/`.
- Use `flutter test test/widget` to verify UI logic (auth, wallet, lobby flows).

## Golden Tests
- Located under `test/golden/`.
- Use `flutter test --update-goldens` to regenerate baselines when UI changes are intentional.

## Mocking Firebase
- Use `fake_cloud_firestore` and `mockito` to stub Firestore and Auth dependencies.
- For GetX controllers, override bindings with test modules.

## Continuous Integration
- GitHub Actions workflow (`.github/workflows/ci.yaml`) runs `flutter test` and `flutter analyze` on pushes and PRs.

## Coverage
Generate coverage report:
```bash
flutter test --coverage
lcov --remove coverage/lcov.info 'lib/generated/*' -o coverage/lcov.info
```
Open with VS Code Coverage Gutters or upload to your CI service.
