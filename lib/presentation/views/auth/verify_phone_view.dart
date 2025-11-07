import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../widgets/primary_button.dart';

class VerifyPhoneView extends StatelessWidget {
  VerifyPhoneView({super.key});

  final phoneController = TextEditingController();
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Phone')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Phone number'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: otpController,
              decoration: const InputDecoration(labelText: 'OTP'),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Verify & Continue',
              onPressed: () => Get.offAllNamed(AppRoutes.kycUpload),
            ),
          ],
        ),
      ),
    );
  }
}
