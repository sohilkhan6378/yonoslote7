import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../controllers/kyc_controller.dart';
import '../../widgets/primary_button.dart';

class KycUploadView extends StatelessWidget {
  KycUploadView({super.key});

  final panController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KycController>();
    final authUid = 'mock-user';

    return Scaffold(
      appBar: AppBar(title: const Text('KYC Upload')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: panController,
              decoration: const InputDecoration(labelText: 'PAN Number (masked)'),
            ),
            const SizedBox(height: 16),
            const Text('Upload ID front/back and selfie via Storage UI (placeholder).'),
            const Spacer(),
            Obx(() {
              final loading = controller.uploading.value;
              return PrimaryButton(
                label: loading ? 'Submitting…' : 'Submit KYC',
                onPressed: loading
                    ? null
                    : () async {
                        await controller.submitDocuments(
                          uid: authUid,
                          panMasked: panController.text,
                          frontUrl: 'https://example.com/front',
                          backUrl: 'https://example.com/back',
                          selfieUrl: 'https://example.com/selfie',
                        );
                        Get.toNamed(AppRoutes.kycStatus);
                      },
              );
            }),
          ],
        ),
      ),
    );
  }
}
