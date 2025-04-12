import 'package:ator_math_game/admob/interstitial_ad_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}

bool isNullOrEmpty(String? text) {
  if (text != null && text.isNotEmpty) return false;

  return true;
}

double getScreenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double getScreenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

DateTime setDateToStartOfDay(DateTime date) {
  return DateTime(date.year, date.month, date.day, 0, 1);
}

DateTime setDateToEndOfDay(DateTime date) {
  return DateTime(date.year, date.month, date.day, 23, 59);
}

Future<int> getBestScore(int score) async {
  const bestScoreKey = 'BESTSCORE';
  final prefs = await SharedPreferences.getInstance();
  final bestScore = prefs.getInt(bestScoreKey) ?? 0;
  if (score > bestScore) {
    await prefs.setInt(bestScoreKey, score);
    return score;
  }
  return bestScore;
}

goto(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

gotoWithAd(BuildContext context, Widget page, {bool isReplace = false}) {
  gotoReplace(
      context, InterstitialAdWidget(nextPage: page, isReplace: isReplace));
}

gotoReplace(BuildContext context, Widget page) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => page));
}
