import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/constants/strings.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/theme/app_styles.dart';

class DiffBadge extends StatelessWidget {
  final int level;

  const DiffBadge({super.key, required this.level});

  Color get _bg => level == 1 ? AppColors.learnLight : level == 2 ? AppColors.practiceLight : AppColors.dangerLight;
  Color get _fg => level == 1 ? AppColors.diffEasy : level == 2 ? AppColors.diffMed : AppColors.diffHard;

  @override
  Widget build(BuildContext context) {
    final label = AppStrings.diffBadgeLabels[level];
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: _bg,
        borderRadius: AppRadius.smBr,
        border: Border.all(color: _fg.withValues(alpha: 0.2)),
      ),
      child: Text(label, style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: _fg,
      )),
    );
  }
}
