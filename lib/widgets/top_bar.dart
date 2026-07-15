import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';

class TopBar extends StatelessWidget {
  final Widget? left;
  final String? title;
  final String? subtitle;
  final Widget? right;

  const TopBar({
    super.key,
    this.left,
    this.title,
    this.subtitle,
    this.right,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Expanded(flex: 1, child: left ?? const SizedBox.shrink()),
          Flexible(
            flex: 2,
            child: Column(
              children: [
                if (title != null)
                  FittedBox(
                    child: Text(title!, style: const TextStyle(
                      fontFamily: 'Fredoka',
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: AppColors.text,
                    )),
                  ),
                if (subtitle != null)
                  Text(subtitle!, style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  )),
              ],
            ),
          ),
          Expanded(flex: 1, child: right != null ? Align(alignment: Alignment.centerRight, child: right) : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
