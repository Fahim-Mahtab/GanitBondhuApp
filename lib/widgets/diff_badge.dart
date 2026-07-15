import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/constants/strings.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';

class DiffBadge extends StatelessWidget {
  final int level;

  const DiffBadge({super.key, required this.level});

  @override
  Widget build(BuildContext context) {
    final bg = level == 1 ? AppColors.learnLight : level == 2 ? AppColors.practiceLight : AppColors.dangerLight;
    final fg = level == 1 ? AppColors.diffEasy : level == 2 ? AppColors.diffMed : AppColors.diffHard;
    final label = AppStrings.diffBadgeLabels[level];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(label, style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: fg,
      )),
    );
  }
}
