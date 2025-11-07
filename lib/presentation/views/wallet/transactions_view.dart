import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/wallet_controller.dart';

class TransactionsView extends StatelessWidget {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<WalletController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: Obx(() {
        final txs = controller.transactions;
        if (txs.isEmpty) {
          return const Center(child: Text('No transactions yet.'));
        }
        return ListView.builder(
          itemCount: txs.length,
          itemBuilder: (context, index) {
            final tx = txs[index];
            return ListTile(
              title: Text(tx.type.name),
              subtitle: Text(tx.status),
              trailing: Text('₹${tx.amount.toStringAsFixed(2)}'),
            );
          },
        );
      }),
    );
  }
}
