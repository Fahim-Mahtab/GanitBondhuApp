import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const bg = Color(0xFFF4F6FB);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFE2E6EF);
  static const borderLight = Color(0xFFF0F2F6);
  static const primary = Color(0xFF4338CA);
  static const primaryLight = Color(0xFFEEF0FD);
  static const primaryDark = Color(0xFF3730A3);
  static const primaryGradientStart = Color(0xFF4338CA);
  static const primaryGradientEnd = Color(0xFF6366F1);
  static const primaryText = Color(0xFFFFFFFF);
  static const learn = Color(0xFF059669);
  static const learnLight = Color(0xFFECFDF5);
  static const learnDark = Color(0xFF047857);
  static const practice = Color(0xFFD97706);
  static const practiceLight = Color(0xFFFFFBEB);
  static const practiceDark = Color(0xFFB45309);
  static const text = Color(0xFF111827);
  static const textSub = Color(0xFF374151);
  static const textMuted = Color(0xFF6B7280);
  static const textExtraMuted = Color(0xFF9CA3AF);
  static const danger = Color(0xFFDC2626);
  static const dangerLight = Color(0xFFFEF2F2);
  static const diffEasy = Color(0xFF059669);
  static const diffMed = Color(0xFFD97706);
  static const diffHard = Color(0xFFDC2626);

  static const shadowLight = Color(0x0A000000);
  static const shadowMedium = Color(0x12000000);
  static const shadowHeavy = Color(0x1A000000);

  static const topicColors = {
    'addition': learn,
    'subtraction': practice,
    'multiplication': Color(0xFF7C3AED),
    'division': Color(0xFFDC2626),
    'geometry': Color(0xFF2563EB),
    'data': Color(0xFFDB2777),
    'algebra': Color(0xFF0D9488),
  };

  static const topicGradients = {
    'addition': [learn, learnDark],
    'subtraction': [practice, practiceDark],
    'multiplication': [Color(0xFF7C3AED), Color(0xFF6D28D9)],
    'division': [Color(0xFFDC2626), Color(0xFFB91C1C)],
    'geometry': [Color(0xFF2563EB), Color(0xFF1D4ED8)],
    'data': [Color(0xFFDB2777), Color(0xFFBE185D)],
    'algebra': [Color(0xFF0D9488), Color(0xFF0F766E)],
  };
}

extension HexColor on Color {
  static Color fromHex(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) hex = 'FF$hex';
    return Color(int.parse(hex, radix: 16));
  }
}
