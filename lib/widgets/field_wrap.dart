import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';

class FieldWrap extends StatelessWidget {
  final Widget icon;
  final Widget child;

  const FieldWrap({super.key, required this.icon, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned(
          left: 12,
          top: 0,
          bottom: 0,
          child: Center(child: IconTheme(data: const IconThemeData(color: AppColors.textMuted, size: 16), child: icon)),
        ),
      ],
    );
  }
}
