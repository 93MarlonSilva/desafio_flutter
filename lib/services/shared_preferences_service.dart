import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String _highScoreKey = 'highScore';

  static Future<int> getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_highScoreKey) ?? 0;
  }

  static Future<void> setHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_highScoreKey, score);
  }

  static Future<bool> isNewHighScore(int score) async {
    final currentHighScore = await getHighScore();
    return score > currentHighScore;
  }
}
