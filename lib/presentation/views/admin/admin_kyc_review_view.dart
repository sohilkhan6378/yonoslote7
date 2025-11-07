import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/admin_controller.dart';

class AdminKycReviewView extends StatelessWidget {
  const AdminKycReviewView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();
    return Scaffold(
      appBar: AppBar(title: const Text('KYC Review')),
      body: Obx(() {
        final kycs = controller.pendingKycs;
        if (kycs.isEmpty) {
          return const Center(child: Text('No pending KYC requests.'));
        }
        return ListView.builder(
          itemCount: kycs.length,
          itemBuilder: (context, index) {
            final kyc = kycs[index];
            return Card(
              child: ListTile(
                title: Text(kyc.uid),
                subtitle: Text('Status: ${kyc.status}'),
                trailing: Wrap(
                  spacing: 8,
                  children: [
                    ElevatedButton(onPressed: () {}, child: const Text('Approve')),
                    ElevatedButton(onPressed: () {}, child: const Text('Reject')),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
