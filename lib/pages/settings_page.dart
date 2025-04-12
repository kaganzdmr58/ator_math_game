import 'package:ator_math_game/widgets/global_appbar.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final String title;
  const SettingsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(actions: [],title: "Settings Page",),
      body: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            'Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: const Text('Sound'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Handle sound toggle
              },
            ),
          ),
          ListTile(
            title: const Text('Notifications'),
            trailing: Switch(
              value: true,
              onChanged: (value) {
                // Handle notifications toggle
              },
            ),
          ),
        ],
      ),
    );
  }
}
