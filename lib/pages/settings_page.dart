import 'package:ator_math_game/widgets/global_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../enums/game_type.dart';
import '../providers/game_settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final gameSettings = Provider.of<GameSettingsProvider>(context);


    return Scaffold(
      appBar: CustomAppBar(title: 'Ayarlar'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Seçilen Seviye:',
              style: const TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: 200,
              child: DropdownButton<GameType>(
                value: gameSettings.selectedGameType,
                isExpanded: true,
                items: GameType.values.map((type) {
                  return DropdownMenuItem<GameType>(
                    value: type,
                    child: Text(type.name),
                  );
                }).toList(),
                onChanged: (GameType? newValue) {
                  if (newValue != null) {
                    gameSettings.setGameType(newValue);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
