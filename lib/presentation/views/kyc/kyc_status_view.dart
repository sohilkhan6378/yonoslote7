import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/kyc_controller.dart';
import '../../widgets/kyc_status_badge.dart';

class KycStatusView extends StatelessWidget {
  const KycStatusView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<KycController>();
    controller.loadKyc('mock-user');
    return Scaffold(
      appBar: AppBar(title: const Text('KYC Status')),
      body: Center(
        child: Obx(() {
          final kyc = controller.currentKyc.value;
          if (kyc == null) {
            return const CircularProgressIndicator();
          }
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              KycStatusBadge(status: kyc.status),
              const SizedBox(height: 16),
              Text(kyc.reason ?? 'Submitted for review'),
            ],
          );
        }),
      ),
    );
  }
}
