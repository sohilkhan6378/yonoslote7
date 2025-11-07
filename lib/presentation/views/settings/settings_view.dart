import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/settings_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          Obx(() => ListTile(
                leading: const Icon(Icons.percent),
                title: const Text('Current Rake'),
                subtitle: Text('${controller.rakePercentage.value * 100}%'),
              )),
          const ListTile(
            leading: Icon(Icons.health_and_safety),
            title: Text('Responsible Gaming'),
            subtitle: Text('Set self-exclusion, deposit limits, and reminders.'),
          ),
        ],
      ),
    );
  }
}
