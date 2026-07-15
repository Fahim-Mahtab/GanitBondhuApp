import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ganitbondhu_app/constants/strings.dart';
import 'package:ganitbondhu_app/models/topic.dart';
import 'package:ganitbondhu_app/providers/app_state_provider.dart';
import 'package:ganitbondhu_app/screens/chat_screen.dart';
import 'package:ganitbondhu_app/screens/login_screen.dart';
import 'package:ganitbondhu_app/services/math_data.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/theme/app_styles.dart';
import 'package:ganitbondhu_app/widgets/page_shell.dart';
import 'package:ganitbondhu_app/widgets/top_bar.dart';
import 'package:ganitbondhu_app/widgets/logout_button.dart';
import 'package:ganitbondhu_app/widgets/back_button.dart';
import 'package:ganitbondhu_app/widgets/mode_badge.dart';
import 'package:ganitbondhu_app/widgets/diff_badge.dart';
import 'package:ganitbondhu_app/widgets/press_scale.dart';

class SubtopicsScreen extends StatelessWidget {
  final Topic topic;

  const SubtopicsScreen({super.key, required this.topic});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppStateProvider>();
    final subs = MathData.subtopics[topic.id] ?? [];

    return PageShell(
      gradientBg: true,
      child: SafeArea(
        child: Column(
          children: [
            TopBar(
              left: AppBackButton(label: AppStrings.subtopicsBackLabel, onTap: () => Navigator.pop(context)),
              title: topic.name,
              subtitle: AppStrings.subtopicsSubtitle,
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
                      color: AppColors.bg,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        ModeBadge(mode: state.mode),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...subs.map((sub) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: PressScale(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(topic: topic, subtopic: sub))),
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
                              width: 44, height: 44,
                              decoration: BoxDecoration(
                                gradient: AppGradient.topic(topic.id.name),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.extension, size: 20, color: AppColors.primary),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(sub.name, style: const TextStyle(
                                    fontFamily: 'Fredoka',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.text,
                                  )),
                                  const SizedBox(height: 6),
                                  DiffBadge(level: sub.difficulty),
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
