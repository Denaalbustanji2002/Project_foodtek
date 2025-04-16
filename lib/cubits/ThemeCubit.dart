import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../helper/shared_preferences_helper.dart';
import '../states/ThemeState.dart';

class ThemeCubit extends Cubit<ThemeState> {
  static const String _themePreferenceKey = 'app_theme_mode';
  final SharedPreferencesHelper _prefsHelper = SharedPreferencesHelper();

  ThemeCubit()
      : super(
    ThemeState(
      themeMode: ThemeMode.system,
      lightTheme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
    ),
  ) {
    _loadTheme();
  }

  static ThemeData _buildLightTheme() {
    return ThemeData.light().copyWith(
      colorScheme: ColorScheme.light(
        primary: Colors.blue,
        onPrimary: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
      ),
    );
  }

  static ThemeData _buildDarkTheme() {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.dark(
        primary: Colors.blueGrey,
        onPrimary: Colors.white,
        background: Colors.grey[900]!,
        onBackground: Colors.white,
      ),
    );
  }

  Future<void> _loadTheme() async {
    await _prefsHelper.init();
    final themeIndex = await _prefsHelper.getPrefInt(
      key: _themePreferenceKey,
      defaultValue: ThemeMode.system.index,
    );
    final themeMode = ThemeMode.values[themeIndex];
    emit(state.copyWith(themeMode: themeMode));
  }

  Future<void> changeTheme(ThemeMode mode) async {
    await _prefsHelper.savePrefInt(
      key: _themePreferenceKey,
      value: mode.index,
    );
    emit(state.copyWith(themeMode: mode));
  }

  bool get isDarkMode {
    if (state.themeMode == ThemeMode.system) {
      return WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    }
    return state.themeMode == ThemeMode.dark;
  }
}