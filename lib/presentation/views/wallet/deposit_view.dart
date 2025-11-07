import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/wallet_controller.dart';
import '../../widgets/amount_field.dart';
import '../../widgets/primary_button.dart';

class DepositView extends StatelessWidget {
  DepositView({super.key});

  final amountController = TextEditingController(text: '100');

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Deposit')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AmountField(controller: amountController, label: 'Amount'),
            const SizedBox(height: 24),
            Obx(() {
              final loading = controller.loading.value;
              return PrimaryButton(
                label: loading ? 'Processing…' : 'Pay securely',
                onPressed: loading
                    ? null
                    : () => controller.deposit(
                          'mock-user',
                          double.tryParse(amountController.text) ?? 0,
                        ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
