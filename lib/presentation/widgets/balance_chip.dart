import 'package:flutter/material.dart';

class BalanceChip extends StatelessWidget {
  const BalanceChip({super.key, required this.balance});

  final double balance;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: const Icon(Icons.account_balance_wallet, color: Colors.white),
      label: Text(
        '₹${balance.toStringAsFixed(2)}',
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
    );
  }
}
