import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ganitbondhu_app/constants/strings.dart';
import 'package:ganitbondhu_app/providers/app_state_provider.dart';
import 'package:ganitbondhu_app/screens/topics_screen.dart';
import 'package:ganitbondhu_app/screens/login_screen.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/theme/app_styles.dart';
import 'package:ganitbondhu_app/widgets/page_shell.dart';
import 'package:ganitbondhu_app/widgets/logout_button.dart';
import 'package:ganitbondhu_app/widgets/press_scale.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppStateProvider>();

    return PageShell(
      gradientBg: true,
      child: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context, state),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildWelcomeCard(state),
                  const SizedBox(height: 20),
                  _buildSectionTitle(AppStrings.dashboardModeHeading),
                  const SizedBox(height: 12),
                  _buildModeCard(
                    context, state,
                    Icons.menu_book,
                    AppStrings.dashboardLearningTitle,
                    AppStrings.dashboardLearningSub,
                    AppColors.learn,
                    AppColors.learnLight,
                    () { state.setMode(AppMode.learning); Navigator.push(context, MaterialPageRoute(builder: (_) => const TopicsScreen())); },
                  ),
                  const SizedBox(height: 10),
                  _buildModeCard(
                    context, state,
                    Icons.bolt,
                    AppStrings.dashboardPracticeTitle,
                    AppStrings.dashboardPracticeSub,
                    AppColors.practice,
                    AppColors.practiceLight,
                    () { state.setMode(AppMode.practice); Navigator.push(context, MaterialPageRoute(builder: (_) => const TopicsScreen())); },
                  ),
                  const SizedBox(height: 24),
                  _buildSectionTitle(AppStrings.dashboardProgressHeading),
                  const SizedBox(height: 12),
                  _buildStatsGrid(),
                  const SizedBox(height: 20),
                  _buildFooter(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context, AppStateProvider state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [AppShadow.card],
      ),
      child: Row(
        children: [
          Container(
            width: 34, height: 34,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.15), blurRadius: 8)],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset('assets/logo.png', width: 34, height: 34, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 10),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
            ).createShader(bounds),
            child: const Text(AppStrings.dashboardTitle, style: TextStyle(
              fontFamily: 'Fredoka',
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            )),
          ),
          const Spacer(),
          LogoutButton(onTap: () => Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false,
          )),
        ],
      ),
    );
  }

  Widget _buildWelcomeCard(AppStateProvider state) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primaryLight, AppColors.primaryLight.withValues(alpha: 0.5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
        boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.08), blurRadius: 12, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          Container(
            width: 48, height: 48,
            decoration: BoxDecoration(
              gradient: AppGradient.primary,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3))],
            ),
            child: const Icon(Icons.school, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.dashboardWelcome(state.username),
                  style: const TextStyle(fontFamily: 'Fredoka', fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.primary),
                ),
                const SizedBox(height: 4),
                Text(AppStrings.dashboardGradeInfo(state.grade),
                  style: TextStyle(fontSize: 12, color: AppColors.primary.withValues(alpha: 0.6)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
      color: AppColors.textMuted,
    ));
  }

  Widget _buildModeCard(
    BuildContext context,
    AppStateProvider state,
    IconData icon,
    String title,
    String subtitle,
    Color accent,
    Color accentLight,
    VoidCallback onTap,
  ) {
    return PressScale(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.borderLight),
          boxShadow: [AppShadow.card],
        ),
        child: Row(
          children: [
            Container(
              width: 52, height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [accentLight, accent.withValues(alpha: 0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: accent, size: 26),
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
                  const SizedBox(height: 2),
                  Text(subtitle, style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                  )),
                ],
              ),
            ),
            Container(
              width: 28, height: 28,
              decoration: BoxDecoration(
                color: accentLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.chevron_right, size: 16, color: accent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid() {
    final stats = [
      (Icons.auto_awesome, AppStrings.dashboardStatTotalPoints, '142', AppColors.primary),
      (Icons.star, AppStrings.dashboardStatTodayPoints, '18', AppColors.practice),
      (Icons.emoji_events, AppStrings.dashboardStatStreak, '7', AppColors.learn),
      (Icons.workspace_premium, AppStrings.dashboardStatBadges, '4', const Color(0xFF7C3AED)),
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (_, i) {
        final (icon, label, value, color) = stats[i];
        return Container(
          padding: const EdgeInsets.all(14), 
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.borderLight),
            boxShadow: [AppShadow.card],
          ),
          child: Row(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, size: 18, color: color),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(value, style: const TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                    height: 1,
                  )),
                  const SizedBox(height: 2),
                  Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                ],
              ),
            ],
          ),
        );
      },
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
