import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../controllers/table_controller.dart';
import '../../widgets/primary_button.dart';

class TableDetailView extends StatelessWidget {
  const TableDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TableController>();
    final tableId = Get.arguments as String? ?? 'demo-table';
    controller.loadTable(tableId);
    return Scaffold(
      appBar: AppBar(title: const Text('Table Details')),
      body: Obx(() {
        final table = controller.table.value;
        if (table == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Game: ${table.gameType}', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              Text('Entry Fee: ₹${table.entryFee}'),
              const SizedBox(height: 8),
              Text('Players: ${table.players.length}/${table.maxPlayers}'),
              const Spacer(),
              PrimaryButton(
                label: 'Join Table',
                onPressed: () => Get.toNamed(AppRoutes.rummyTable, arguments: table.id),
              ),
            ],
          ),
        );
      }),
    );
  }
}
