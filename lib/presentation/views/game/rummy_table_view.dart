import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';
import '../../controllers/rummy_controller.dart';
import '../../controllers/table_controller.dart';
import '../../widgets/primary_button.dart';

class RummyTableView extends StatefulWidget {
  const RummyTableView({super.key});

  @override
  State<RummyTableView> createState() => _RummyTableViewState();
}

class _RummyTableViewState extends State<RummyTableView> {
  late final TableController tableController;
  late final RummyController rummyController;
  late final String tableId;

  @override
  void initState() {
    super.initState();
    tableController = Get.find<TableController>();
    rummyController = Get.find<RummyController>();
    tableId = Get.arguments as String? ?? 'demo-table';
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      tableController.loadTable(tableId);
      final roundId = await rummyController.startLocalRound(const ['demo-player', 'cpu-1']);
      tableController.subscribeToRound(roundId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rummy Table')),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              final round = tableController.currentRound.value;
              if (round == null) {
                return const Center(child: Text('Waiting for round start...'));
              }
              rummyController.onRoundUpdate(round);
              return ListView(
                padding: const EdgeInsets.all(16),
                children: round.deals.entries
                    .map(
                      (entry) => Card(
                        child: ListTile(
                          title: Text('Player: ${entry.key}'),
                          subtitle: Text(entry.value.join(', ')),
                        ),
                      ),
                    )
                    .toList(),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: PrimaryButton(
              label: 'Declare Hand',
              onPressed: () => Get.toNamed(AppRoutes.rummyResult, arguments: tableId),
            ),
          ),
        ],
      ),
    );
  }
}
