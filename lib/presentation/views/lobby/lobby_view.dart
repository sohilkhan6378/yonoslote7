import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../controllers/lobby_controller.dart';
import '../../widgets/game_card.dart';
import '../../../domain/services/mini_game_engine.dart';

class LobbyView extends StatelessWidget {
  const LobbyView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LobbyController>();
    controller.refreshBalance('mock-user');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lobby'),
        actions: [
          Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Center(
                  child: Text('₹${controller.balance.value.toStringAsFixed(2)}'),
                ),
              )),
        ],
      ),
      body: Obx(() {
        final tables = controller.tables;
        if (tables.isEmpty) {
          return ListView(
            children: [
              GameCard(
                title: 'Mini Game (Demo)',
                subtitle: 'Try our pluggable engine demo',
                onTap: () {
                  final result = Get.find<MiniGameEngine>().start();
                  Get.snackbar('Mini Game', result);
                },
              ),
              const SizedBox(height: 16),
              const Center(child: Text('No cash tables available.')),
            ],
          );
        }
        return ListView.builder(
          itemCount: tables.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return GameCard(
                title: 'Mini Game (Demo)',
                subtitle: 'Try our pluggable engine demo',
                onTap: () {
                  final result = Get.find<MiniGameEngine>().start();
                  Get.snackbar('Mini Game', result);
                },
              );
            }
            final table = tables[index - 1];
            return GameCard(
              title: '${table.gameType} - ₹${table.entryFee}',
              subtitle: '${table.players.length}/${table.maxPlayers} players',
              onTap: () => Get.toNamed(AppRoutes.tableDetail, arguments: table.id),
            );
          },
        );
      }),
    );
  }
}
