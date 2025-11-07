import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app.dart';
import 'config/env.dart';
import 'firebase_options.dart';

/// Shared bootstrap for flavored entrypoints.
Future<void> bootstrap({required String flavor}) async {
  WidgetsFlutterBinding.ensureInitialized();
  Env.loadFromMap({
    'FLAVOR': flavor,
    'RZP_KEY': const String.fromEnvironment('RZP_KEY', defaultValue: 'mock_key'),
    'ALLOWED_REGIONS':
        const String.fromEnvironment('ALLOWED_REGIONS', defaultValue: 'IN'),
  });
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runZonedGuarded(() {
    runApp(const RummyProApp());
  }, (error, stackTrace) {
    // TODO: Wire Crashlytics or custom logging.
  });
}
