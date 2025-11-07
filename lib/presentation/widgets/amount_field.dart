import 'package:flutter/material.dart';

class AmountField extends StatelessWidget {
  const AmountField({super.key, required this.controller, required this.label});

  final TextEditingController controller;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: label,
        prefixText: '₹',
        border: const OutlineInputBorder(),
      ),
    );
  }
}
