import 'package:flutter/material.dart';
import '../../widgets/primary_button.dart';

class AdminWalletAdjustView extends StatelessWidget {
  AdminWalletAdjustView({super.key});

  final uidController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wallet Adjustments')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: uidController,
              decoration: const InputDecoration(labelText: 'User UID'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Credit',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Credited ₹${amountController.text} to ${uidController.text}')),
                );
              },
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: 'Debit',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Debited ₹${amountController.text} from ${uidController.text}')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
