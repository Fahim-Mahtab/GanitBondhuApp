import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/theme/app_styles.dart';

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
      padding: const EdgeInsets.only(left: 16, right: 12, top: 12, bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [AppShadow.card],
      ),
      child: Row(
        children: [
          if (left != null) Align(alignment: Alignment.centerLeft, child: left!),
          if (left != null) const SizedBox(width: 8),
          if (title != null)
            Expanded(
              child: Column(
                children: [
                  Text(title!, style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppColors.text,
                  )),
                  if (subtitle != null)
                    Text(subtitle!, style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.textMuted,
                    )),
                ],
              ),
            ),
          if (right != null) const SizedBox(width: 8),
          if (right != null) Align(alignment: Alignment.centerRight, child: right!),
        ],
      ),
    );
  }
}
