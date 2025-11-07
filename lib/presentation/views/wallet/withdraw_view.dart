import 'package:flutter/material.dart';

import '../../widgets/amount_field.dart';
import '../../widgets/primary_button.dart';

class WithdrawView extends StatelessWidget {
  WithdrawView({super.key});

  final amountController = TextEditingController(text: '500');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Withdraw')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            AmountField(controller: amountController, label: 'Amount'),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Request Withdrawal',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Withdrawal request submitted')), 
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
