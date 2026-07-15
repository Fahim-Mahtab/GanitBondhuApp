import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ganitbondhu_app/constants/strings.dart';
import 'package:ganitbondhu_app/providers/app_state_provider.dart';
import 'package:ganitbondhu_app/screens/subtopics_screen.dart';
import 'package:ganitbondhu_app/screens/login_screen.dart';
import 'package:ganitbondhu_app/services/math_data.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/theme/app_styles.dart';
import 'package:ganitbondhu_app/widgets/page_shell.dart';
import 'package:ganitbondhu_app/widgets/top_bar.dart';
import 'package:ganitbondhu_app/widgets/logout_button.dart';
import 'package:ganitbondhu_app/widgets/back_button.dart';
import 'package:ganitbondhu_app/widgets/mode_badge.dart';
import 'package:ganitbondhu_app/widgets/press_scale.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppStateProvider>();

    return PageShell(
      gradientBg: true,
      child: SafeArea(
        child: Column(
          children: [
            TopBar(
              left: AppBackButton(label: AppStrings.topicsBackLabel, onTap: () => Navigator.pop(context)),
              title: AppStrings.topicsTitle,
              subtitle: AppStrings.topicsSubtitle(state.grade),
              right: LogoutButton(onTap: () => Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false,
              )),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        ModeBadge(mode: state.mode),
                        const SizedBox(width: 10),
                        const Text(AppStrings.topicsPrompt, style: TextStyle(fontSize: 13, color: AppColors.textSub)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...MathData.topics.map((topic) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: PressScale(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SubtopicsScreen(topic: topic))),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: AppColors.borderLight),
                          boxShadow: [AppShadow.card],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48, height: 48,
                              decoration: BoxDecoration(
                                gradient: AppGradient.topic(topic.id.name),
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Icon(topic.icon, size: 22, color: topic.id.color),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(topic.name, style: const TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.text,
                                  )),
                                  const SizedBox(height: 2),
                                  Text(topic.subname, style: const TextStyle(
                                    fontSize: 12,
                                    color: AppColors.textMuted,
                                  )),
                                ],
                              ),
                            ),
                            Container(
                              width: 26, height: 26,
                              decoration: BoxDecoration(
                                color: AppColors.bg,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(Icons.chevron_right, size: 16, color: AppColors.textExtraMuted),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
