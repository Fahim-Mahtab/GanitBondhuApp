import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/constants/strings.dart';
import 'package:ganitbondhu_app/providers/app_state_provider.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';

class ModeBadge extends StatelessWidget {
  final AppMode mode;

  const ModeBadge({super.key, required this.mode});

  @override
  Widget build(BuildContext context) {
    final isLearn = mode == AppMode.learning;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isLearn
              ? [AppColors.learnLight, AppColors.learnLight]
              : [AppColors.practiceLight, AppColors.practiceLight],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (isLearn ? AppColors.learn : AppColors.practice).withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        isLearn ? AppStrings.modeBadgeLearning : AppStrings.modeBadgePractice,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: isLearn ? AppColors.learn : AppColors.practice,
        ),
      ),
    );
  }
}
