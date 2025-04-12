/* import 'package:ator_math_game/enums/game_type.dart';
import 'package:flutter/material.dart';

class GameSettingsProvider extends ChangeNotifier {
  GameType _selectedGameType = GameType.easy;

  GameType get selectedGameType => _selectedGameType;

  void setGameType(GameType type) {
    _selectedGameType = type;
    notifyListeners(); 
  }
}
 */

import 'package:ator_math_game/enums/game_type.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameSettingsProvider extends ChangeNotifier {
  GameType _selectedGameType = GameType.easy;

  GameType get selectedGameType => _selectedGameType;

  GameSettingsProvider() {
    _loadGameType();
  }

  // SharedPreferences'ten GameType'ı yükle
  Future<void> _loadGameType() async {
    final prefs = await SharedPreferences.getInstance();
    final savedId = prefs.getInt('game_type_id');

    if (savedId != null) {
      // Kaydedilen id'ye göre GameType'ı al
      _selectedGameType = GameType.values.firstWhere(
        (type) => type.id == savedId,
        orElse: () => GameType.easy, // Varsayılan olarak easy seç
      );
    }
    notifyListeners(); // Değişiklikleri dinleyenlere bildir
  }

  // GameType'ı güncelle ve SharedPreferences'e kaydet
  Future<void> setGameType(GameType type) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('game_type_id', type.id); // SharedPreferences'e kaydet
    _selectedGameType = type;
    notifyListeners(); // Değişiklikleri dinleyenlere bildir
  }
}
