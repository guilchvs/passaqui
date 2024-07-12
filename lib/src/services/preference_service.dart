import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static const _selectedPeriodKey = 'selectedPeriod';

  static Future<void> saveSelectedPeriod(int period) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_selectedPeriodKey, period);
  }

  static Future<int?> getSelectedPeriod() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_selectedPeriodKey);
  }
}
