import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/theme/app_styles.dart';

class PageShell extends StatelessWidget {
  final Widget child;
  final bool gradientBg;

  const PageShell({super.key, required this.child, this.gradientBg = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: gradientBg ? const BoxDecoration(gradient: AppGradient.bg) : null,
        color: gradientBg ? null : AppColors.bg,
        child: SafeArea(child: child),
      ),
    );
  }
}
