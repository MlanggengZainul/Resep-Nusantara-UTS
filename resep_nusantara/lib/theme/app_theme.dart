import 'package:flutter/material.dart';

/// Palet warna bertema ubi ungu: konsisten di seluruh halaman.
class AppColors {
  static const primary = Color(0xFF6B3FA0);
  static const dark = Color(0xFF2E1F47);
  static const background = Color(0xFFF8F6FB);
  static const accent = Color(0xFFFFB347);
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.dark,
      foregroundColor: Colors.white,
      centerTitle: false,
    ),
  );
}
