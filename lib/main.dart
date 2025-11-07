import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app.dart';
import 'config/env.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Env.loadFromMap(const String.fromEnvironment('FLAVOR').isEmpty
      ? const <String, String>{}
      : {
          'FLAVOR': const String.fromEnvironment('FLAVOR'),
          'RZP_KEY': const String.fromEnvironment('RZP_KEY'),
          'ALLOWED_REGIONS': const String.fromEnvironment('ALLOWED_REGIONS'),
        });
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const RummyProApp());
}
