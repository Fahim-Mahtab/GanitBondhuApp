import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';

class PageShell extends StatelessWidget {
  final Widget child;

  const PageShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 430,
          color: AppColors.surface,
          child: child,
        ),
      ),
    );
  }
}
