import 'package:ator_math_game/enums/game_type.dart';
import 'package:flutter/material.dart';

class GameSettingsProvider extends ChangeNotifier {
  GameType _selectedGameType = GameType.easy;

  GameType get selectedGameType => _selectedGameType;

  void setGameType(GameType type) {
    _selectedGameType = type;
    notifyListeners(); 
  }
}
