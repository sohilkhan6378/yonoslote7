import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/admin_controller.dart';

class AdminTablesView extends StatelessWidget {
  const AdminTablesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AdminController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Manage Tables')),
      body: Obx(() {
        final tables = controller.adminTables;
        if (tables.isEmpty) {
          return const Center(child: Text('No active tables.'));
        }
        return ListView.builder(
          itemCount: tables.length,
          itemBuilder: (context, index) {
            final table = tables[index];
            return ListTile(
              title: Text('Table ${table.id}'),
              subtitle: Text('State: ${table.state}'),
              trailing: Text('${table.players.length}/${table.maxPlayers} players'),
            );
          },
        );
      }),
    );
  }
}
