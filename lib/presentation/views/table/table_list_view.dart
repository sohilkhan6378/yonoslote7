import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/lobby_controller.dart';
import '../../widgets/game_card.dart';

class TableListView extends StatelessWidget {
  const TableListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LobbyController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Tables')),
      body: Obx(() {
        final tables = controller.tables;
        if (tables.isEmpty) {
          return const Center(child: Text('No tables available'));
        }
        return ListView(
          children: tables
              .map(
                (table) => GameCard(
                  title: table.gameType,
                  subtitle: 'Entry ₹${table.entryFee}',
                  onTap: () => Get.back(result: table.id),
                ),
              )
              .toList(),
        );
      }),
    );
  }
}
