import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/constants/strings.dart';
import 'package:ganitbondhu_app/models/subtopic.dart';
import 'package:ganitbondhu_app/models/topic.dart';
import 'package:ganitbondhu_app/screens/chat_screen.dart';
import 'package:ganitbondhu_app/screens/subtopics_screen.dart';
import 'package:ganitbondhu_app/screens/dashboard_screen.dart';
import 'package:ganitbondhu_app/services/math_data.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/theme/app_styles.dart';
import 'package:ganitbondhu_app/widgets/page_shell.dart';
import 'package:ganitbondhu_app/widgets/top_bar.dart';
import 'package:ganitbondhu_app/widgets/logout_button.dart';
import 'package:ganitbondhu_app/widgets/back_button.dart';
import 'package:ganitbondhu_app/widgets/diff_badge.dart';
import 'package:ganitbondhu_app/widgets/press_scale.dart';

class SameLevelScreen extends StatelessWidget {
  final Topic topic;
  final Subtopic subtopic;

  const SameLevelScreen({super.key, required this.topic, required this.subtopic});

  @override
  Widget build(BuildContext context) {
    final subs = MathData.subtopics[topic.id] ?? [];
    final level = subtopic.difficulty;
    final others = subs.where((s) => s.difficulty == level && s.id != subtopic.id).toList();

    return PageShell(
      gradientBg: true,
      child: SafeArea(
        child: Column(
          children: [
            TopBar(
              left: AppBackButton(label: AppStrings.sameLevelBackLabel, onTap: () => Navigator.pop(context)),
              title: AppStrings.sameLevelTitle(topic.name, level),
              subtitle: AppStrings.sameLevelSubtitle,
              right: LogoutButton(onTap: () => Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (_) => const DashboardScreen()), (_) => false,
              )),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primaryLight, AppColors.primaryLight.withValues(alpha: 0.3)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 1),
                          child: Icon(Icons.trending_up, size: 18, color: AppColors.primary),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(AppStrings.sameLevelInfo, style: TextStyle(fontSize: 13, color: AppColors.primary, height: 1.4)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (others.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 48),
                      child: Column(
                        children: [
                          Container(
                            width: 64, height: 64,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppColors.learnLight, AppColors.learnLight.withValues(alpha: 0.3)],
                              ),
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: AppColors.learn.withValues(alpha: 0.15), blurRadius: 16)],
                            ),
                            child: const Icon(Icons.check_circle, size: 32, color: AppColors.learn),
                          ),
                          const SizedBox(height: 16),
                          const Text(AppStrings.sameLevelEmpty,
                            style: TextStyle(fontFamily: 'Fredoka', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.text),
                          ),
                        ],
                      ),
                    )
                  else
                    ...others.map((sub) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: PressScale(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => ChatScreen(topic: topic, subtopic: sub)),
                        ),
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
                  const SizedBox(height: 16),
                  _buildActionButton(
                    label: AppStrings.sameLevelShowAll,
                    outlined: true,
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SubtopicsScreen(topic: topic))),
                  ),
                  const SizedBox(height: 8),
                  _buildActionButton(
                    label: AppStrings.sameLevelDashboard,
                    onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const DashboardScreen()),
                      (_) => false,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({required String label, bool outlined = false, required VoidCallback onTap}) {
    return PressScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: outlined ? null : AppGradient.primary,
          borderRadius: BorderRadius.circular(14),
          border: outlined ? Border.all(color: AppColors.border) : null,
          boxShadow: outlined ? null : [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Text(label, textAlign: TextAlign.center, style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          fontFamily: outlined ? null : 'Fredoka',
          color: outlined ? AppColors.textSub : Colors.white,
        )),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.science_outlined, size: 12, color: AppColors.textExtraMuted),
        const SizedBox(width: 6),
        Text(AppStrings.developedBy, style: TextStyle(fontSize: 11, color: AppColors.textExtraMuted)),
      ],
    );
  }
}
