import 'package:flutter/material.dart';

/// Simple ValueNotifier that drives ThemeMode across the app.
class ThemeController extends ValueNotifier<ThemeMode> {
  ThemeController() : super(ThemeMode.system);

  void setLight() => value = ThemeMode.light;
  void setDark() => value = ThemeMode.dark;
  void setSystem() => value = ThemeMode.system;

  void toggle() {
    if (value == ThemeMode.dark) {
      value = ThemeMode.light;
    } else {
      value = ThemeMode.dark;
    }
  }

  bool get isDark => value == ThemeMode.dark;
}
