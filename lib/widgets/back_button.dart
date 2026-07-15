import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/widgets/press_scale.dart';

class AppBackButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AppBackButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return PressScale(
      scale: 0.93,
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.chevron_left, size: 20, color: AppColors.primary),
          const SizedBox(width: 2),
          Text(label, style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          )),
        ],
      ),
    );
  }
}
