import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:rummy_pro/presentation/views/onboarding_view.dart';

void main() {
  testWidgets('Onboarding golden', (tester) async {
    const widget = GetMaterialApp(home: OnboardingView());
    await tester.pumpWidget(widget);
    await tester.pumpAndSettle();
    final file = File('test/golden/onboarding_view.png');
    await expectLater(find.byType(OnboardingView), matchesGoldenFile(file.path));
  });
}
