import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: CircleAvatar(child: Icon(Icons.person)),
            title: Text('Player Name'),
            subtitle: Text('player@example.com'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.security),
            title: Text('KYC Status'),
            subtitle: Text('Pending'),
          ),
        ],
      ),
    );
  }
}
