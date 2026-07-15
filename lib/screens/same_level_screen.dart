import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/constants/strings.dart';
import 'package:ganitbondhu_app/models/subtopic.dart';
import 'package:ganitbondhu_app/models/topic.dart';
import 'package:ganitbondhu_app/screens/chat_screen.dart';
import 'package:ganitbondhu_app/screens/subtopics_screen.dart';
import 'package:ganitbondhu_app/screens/dashboard_screen.dart';
import 'package:ganitbondhu_app/services/math_data.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/widgets/page_shell.dart';
import 'package:ganitbondhu_app/widgets/top_bar.dart';
import 'package:ganitbondhu_app/widgets/logout_button.dart';
import 'package:ganitbondhu_app/widgets/back_button.dart';
import 'package:ganitbondhu_app/widgets/diff_badge.dart';

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
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFC7D2FE)),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 2),
                          child: Icon(Icons.trending_up, size: 18, color: AppColors.primary),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text('🎯 একই কঠিনতার সাবটপিক যেগুলো এখনো আয়ত্ত হয়নি সেগুলো দেখাচ্ছি।',
                            style: TextStyle(fontSize: 14, color: AppColors.primary)),
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
                            decoration: BoxDecoration(color: AppColors.learnLight, shape: BoxShape.circle),
                            child: const Icon(Icons.check_circle, size: 32, color: AppColors.learn),
                          ),
                          const SizedBox(height: 12),
                          const Text(AppStrings.sameLevelEmpty,
                            style: TextStyle(fontFamily: 'Fredoka', fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.text),
                          ),
                        ],
                      ),
                    )
                  else
                    ...others.map((sub) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        onTap: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => ChatScreen(topic: topic, subtopic: sub)),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                            boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 1))],
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 40, height: 40,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight,
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
                                    const SizedBox(height: 4),
                                    DiffBadge(level: sub.difficulty),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right, color: AppColors.textMuted),
                            ],
                          ),
                        ),
                      ),
                    )),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => SubtopicsScreen(topic: topic)),
                      ),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textSub,
                        side: BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text(AppStrings.sameLevelShowAll, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const DashboardScreen()),
                        (_) => false,
                      ),
                      child: const Text(AppStrings.sameLevelDashboard, style: TextStyle(
                        fontFamily: 'Fredoka',
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      )),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.science, size: 12, color: AppColors.textMuted),
                      const SizedBox(width: 6),
                      Text(AppStrings.developedBy,
                        style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
