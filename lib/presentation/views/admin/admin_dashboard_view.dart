import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/admin_controller.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: Obx(() {
        return GridView.count(
          padding: const EdgeInsets.all(16),
          crossAxisCount: MediaQuery.of(context).size.width > 600 ? 3 : 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: [
            _StatCard(label: 'Users', value: controller.users.length.toString()),
            _StatCard(label: 'Pending KYC', value: controller.pendingKycs.length.toString()),
            _StatCard(label: 'Active Tables', value: controller.adminTables.length.toString()),
            _StatCard(
              label: 'Wallet Float',
              value: '₹${controller.totalWalletBalance.value.toStringAsFixed(0)}',
            ),
            _StatCard(
              label: 'Recent Transactions',
              value: controller.latestTransactions.length.toString(),
            ),
          ],
        );
      }),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(value, style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ),
    );
  }
}
