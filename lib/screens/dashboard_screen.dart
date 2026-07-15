import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ganitbondhu_app/constants/strings.dart';
import 'package:ganitbondhu_app/providers/app_state_provider.dart';
import 'package:ganitbondhu_app/screens/topics_screen.dart';
import 'package:ganitbondhu_app/screens/login_screen.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/widgets/page_shell.dart';
import 'package:ganitbondhu_app/widgets/logout_button.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppStateProvider>();
    final stats = [
      (_buildStat(Icons.psychology, AppStrings.dashboardStatTotalPoints, '142', AppColors.primary)),
      (_buildStat(Icons.star, AppStrings.dashboardStatTodayPoints, '18', AppColors.practice)),
      (_buildStat(Icons.emoji_events, AppStrings.dashboardStatStreak, '7', AppColors.learn)),
      (_buildStat(Icons.workspace_premium, AppStrings.dashboardStatBadges, '4', const Color(0xFF7C3AED))),
    ];

    return PageShell(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: AppColors.surface,
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32, height: 32,
                    decoration: BoxDecoration(color: AppColors.bg, borderRadius: BorderRadius.circular(8)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.asset('assets/logo.png', width: 32, height: 32, fit: BoxFit.contain),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Text(AppStrings.dashboardTitle, style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  )),
                  const Spacer(),
                  LogoutButton(onTap: () => Navigator.pushAndRemoveUntil(
                    context, MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false,
                  )),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: const Color(0xFFC7D2FE)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48, height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.school, color: Colors.white, size: 26),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.dashboardWelcome(state.username),
                                style: const TextStyle(
                                  fontFamily: 'Fredoka',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(AppStrings.dashboardGradeInfo(state.grade),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.primary.withValues(alpha: 0.6),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(AppStrings.dashboardModeHeading, style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: AppColors.textMuted,
                  )),
                  const SizedBox(height: 12),
                  _buildModeCard(
                    context,
                    Icons.psychology,
                    AppStrings.dashboardLearningTitle,
                    AppStrings.dashboardLearningSub,
                    AppColors.learn,
                    AppColors.learnLight,
                    () {
                      state.setMode(AppMode.learning);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const TopicsScreen()));
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildModeCard(
                    context,
                    Icons.bolt,
                    AppStrings.dashboardPracticeTitle,
                    AppStrings.dashboardPracticeSub,
                    AppColors.practice,
                    AppColors.practiceLight,
                    () {
                      state.setMode(AppMode.practice);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const TopicsScreen()));
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text(AppStrings.dashboardProgressHeading, style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                    color: AppColors.textMuted,
                  )),
                  const SizedBox(height: 12),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 2.2,
                    children: stats,
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

  Widget _buildModeCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Color accent,
    Color accentLight,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border, width: 1.5),
          boxShadow: const [BoxShadow(color: Color(0x0D000000), blurRadius: 6, offset: Offset(0, 1))],
        ),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(
                color: accentLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: accent, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  )),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  )),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textMuted),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(IconData icon, String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            width: 36, height: 36,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: color),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.text,
                height: 1,
              )),
              const SizedBox(height: 4),
              Text(label, style: const TextStyle(
                fontSize: 12,
                color: AppColors.textMuted,
              )),
            ],
          ),
        ],
      ),
    );
  }
}
