import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const bg = Color(0xFFF4F6FB);
  static const surface = Color(0xFFFFFFFF);
  static const border = Color(0xFFE2E6EF);
  static const primary = Color(0xFF4338CA);
  static const primaryLight = Color(0xFFEEF0FD);
  static const primaryText = Color(0xFFFFFFFF);
  static const learn = Color(0xFF059669);
  static const learnLight = Color(0xFFECFDF5);
  static const practice = Color(0xFFD97706);
  static const practiceLight = Color(0xFFFFFBEB);
  static const text = Color(0xFF111827);
  static const textSub = Color(0xFF374151);
  static const textMuted = Color(0xFF6B7280);
  static const danger = Color(0xFFDC2626);
  static const dangerLight = Color(0xFFFEF2F2);
  static const diffEasy = Color(0xFF059669);
  static const diffMed = Color(0xFFD97706);
  static const diffHard = Color(0xFFDC2626);

  static const topicColors = {
    'addition': learn,
    'subtraction': practice,
    'multiplication': Color(0xFF7C3AED),
    'division': Color(0xFFDC2626),
    'geometry': Color(0xFF2563EB),
    'data': Color(0xFFDB2777),
    'algebra': Color(0xFF0D9488),
  };
}
