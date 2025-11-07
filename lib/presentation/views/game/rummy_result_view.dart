import 'package:flutter/material.dart';

class RummyResultView extends StatelessWidget {
  const RummyResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Round Result')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.emoji_events, size: 72, color: Colors.amber),
            SizedBox(height: 16),
            Text('Congratulations! Results will be pushed via notifications.'),
          ],
        ),
      ),
    );
  }
}
