import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

import 'package:rummy_pro/presentation/views/onboarding_view.dart';

void main() {
  testWidgets('Onboarding displays headline and button', (tester) async {
    await tester.pumpWidget(const GetMaterialApp(home: OnboardingView()));
    expect(find.text('RummyPro'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);
    await tester.tap(find.text('Get Started'));
  });
}
