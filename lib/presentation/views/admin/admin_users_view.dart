import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/admin_controller.dart';

class AdminUsersView extends StatelessWidget {
  const AdminUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: Obx(() => ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              final user = controller.users[index];
              return ListTile(
                leading: const Icon(Icons.person),
                title: Text(user.displayName ?? user.email ?? user.uid),
                subtitle: Text('KYC: ${user.kycStatus}'),
              );
            },
          )),
    );
  }
}
