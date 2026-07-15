import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const AppBackButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.chevron_left, size: 18, color: AppColors.primary),
          const SizedBox(width: 2),
          Text(label, style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          )),
        ],
      ),
    );
  }
}
