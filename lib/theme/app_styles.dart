import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppShadow {
  static const card = BoxShadow(
    color: AppColors.shadowLight,
    blurRadius: 8,
    offset: Offset(0, 2),
  );
  static const cardElevated = BoxShadow(
    color: AppColors.shadowMedium,
    blurRadius: 16,
    offset: Offset(0, 4),
  );
  static const modal = BoxShadow(
    color: AppColors.shadowHeavy,
    blurRadius: 24,
    offset: Offset(0, 8),
  );
  static const button = BoxShadow(
    color: Color(0x26000000),
    blurRadius: 8,
    offset: Offset(0, 3),
  );
}

class AppRadius {
  static const sm = 8.0;
  static const md = 12.0;
  static const lg = 16.0;
  static const xl = 20.0;
  static const full = 999.0;

  static BorderRadius get smBr => BorderRadius.circular(sm);
  static BorderRadius get mdBr => BorderRadius.circular(md);
  static BorderRadius get lgBr => BorderRadius.circular(lg);
  static BorderRadius get xlBr => BorderRadius.circular(xl);
}

class AppGradient {
  static const primary = LinearGradient(
    colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static LinearGradient topic(String id) {
    final colors = AppColors.topicGradients[id] ?? AppColors.topicGradients['addition']!;
    return LinearGradient(
      colors: [colors[0].withValues(alpha: 0.15), colors[1].withValues(alpha: 0.05)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }
  static const bg = LinearGradient(
    colors: [Color(0xFFF4F6FB), Color(0xFFEEF2FF), Color(0xFFF4F6FB)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
