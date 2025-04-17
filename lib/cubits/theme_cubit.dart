import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../states/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.light) {
    _loadTheme();
  }

  // Load theme from shared preferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool('isDarkMode') ?? false;
    emit(isDarkMode ? ThemeState.dark : ThemeState.light);
  }

  // Toggle theme
  void toggleTheme() async {
    final newState = state == ThemeState.light ? ThemeState.dark : ThemeState.light;
    emit(newState);

    // Save preference
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', newState == ThemeState.dark);
  }

  // Check if dark mode is active
  bool get isDarkMode => state == ThemeState.dark;
}