import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../controllers/wallet_controller.dart';
import '../../widgets/balance_chip.dart';
import '../../widgets/primary_button.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletController>();
    controller.loadWallet('mock-user');
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              final balance = controller.wallet.value?.balance ?? 0;
              return BalanceChip(balance: balance);
            }),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Deposit',
              onPressed: () => Get.toNamed(AppRoutes.deposit),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: 'Withdraw',
              onPressed: () => Get.toNamed(AppRoutes.withdraw),
            ),
            TextButton(
              onPressed: () => Get.toNamed(AppRoutes.transactions),
              child: const Text('View transactions'),
            ),
          ],
        ),
      ),
    );
  }
}
