import 'package:flutter/material.dart';

class AdminReportsView extends StatelessWidget {
  const AdminReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    final fromController = TextEditingController();
    final toController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: fromController,
              decoration: const InputDecoration(labelText: 'From Date (YYYY-MM-DD)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: toController,
              decoration: const InputDecoration(labelText: 'To Date (YYYY-MM-DD)'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('CSV export queued.')),
                );
              },
              child: const Text('Export CSV'),
            ),
          ],
        ),
      ),
    );
  }
}
