import 'package:flutter/material.dart';

class KycStatusBadge extends StatelessWidget {
  const KycStatusBadge({super.key, required this.status});

  final String status;

  Color _colorForStatus() {
    switch (status) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Chip(
      backgroundColor: _colorForStatus().withOpacity(0.1),
      avatar: Icon(Icons.verified, color: _colorForStatus()),
      label: Text(status.toUpperCase()),
    );
  }
}
