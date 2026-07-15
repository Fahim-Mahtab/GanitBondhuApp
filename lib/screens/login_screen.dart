import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ganitbondhu_app/constants/strings.dart';
import 'package:ganitbondhu_app/providers/app_state_provider.dart';
import 'package:ganitbondhu_app/screens/signup_screen.dart';
import 'package:ganitbondhu_app/screens/dashboard_screen.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/theme/app_styles.dart';
import 'package:ganitbondhu_app/widgets/page_shell.dart';
import 'package:ganitbondhu_app/widgets/press_scale.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _showPass = false;
  String? _error;
  late AnimationController _bgAnimCtrl;

  @override
  void initState() {
    super.initState();
    _bgAnimCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 12));
    _bgAnimCtrl.repeat();
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    _bgAnimCtrl.dispose();
    super.dispose();
  }

  void _handleLogin() {
    final user = _userCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    if (user.isEmpty) { setState(() => _error = AppStrings.loginErrorUsername); return; }
    if (pass.isEmpty) { setState(() => _error = AppStrings.loginErrorPassword); return; }
    context.read<AppStateProvider>().setUsername(user);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const DashboardScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return PageShell(
      gradientBg: true,
      child: Stack(
        children: [
          AnimatedBuilder(
            animation: _bgAnimCtrl,
            builder: (_, _) => _buildFloatingIcons(),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  _buildLogo(),
                  const SizedBox(height: 40),
                  _buildLoginCard(),
                  const SizedBox(height: 24),
                  _buildFooter(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingIcons() {
    final icons = [Icons.add, Icons.remove, Icons.close, Icons.calculate, Icons.category, Icons.bar_chart];
    return Stack(
      children: List.generate(12, (i) {
        final x = (sin(_bgAnimCtrl.value * 2 * pi + i * 1.2) * 0.5 + 0.5) * 0.8 + 0.1;
        final y = (cos(_bgAnimCtrl.value * 2 * pi + i * 1.7) * 0.5 + 0.5) * 0.8 + 0.1;
        final opacity = (sin(_bgAnimCtrl.value * 3 + i * 2.1) * 0.5 + 0.5) * 0.08;
        return Positioned(
          left: MediaQuery.of(context).size.width * x - 15,
          top: MediaQuery.of(context).size.height * y - 15,
          child: Opacity(
            opacity: opacity.clamp(0.02, 0.08),
            child: Icon(icons[i % icons.length], size: 30 + (i % 3) * 5.0, color: AppColors.primary),
          ),
        );
      }),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(color: AppColors.primary.withValues(alpha: 0.20), blurRadius: 30, offset: const Offset(0, 8)),
              BoxShadow(color: AppColors.shadowLight, blurRadius: 4, offset: const Offset(0, 1)),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: Image.asset('assets/logo.png', width: 100, height: 100, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 16),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
          ).createShader(bounds),
          child: const Text(AppStrings.loginTitle, style: TextStyle(
            fontFamily: 'Fredoka',
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          )),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(AppStrings.loginTagline, style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: AppColors.primary.withValues(alpha: 0.8),
          )),
        ),
      ],
    );
  }

  Widget _buildLoginCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(color: AppColors.shadowMedium, blurRadius: 30, offset: const Offset(0, 8)),
          BoxShadow(color: AppColors.shadowLight, blurRadius: 4, offset: const Offset(0, 1)),
        ],
      ),
      child: Column(
        children: [
          const Text(AppStrings.loginCardTitle, style: TextStyle(
            fontFamily: 'Fredoka',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          )),
          const SizedBox(height: 6),
          const Text(AppStrings.loginCardSubtitle, style: TextStyle(
            fontSize: 13,
            color: AppColors.textMuted,
          )),
          const SizedBox(height: 20),
          if (_error != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.dangerLight,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.danger.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Text(AppStrings.loginWarningEmoji, style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 8),
                  Text(_error!, style: const TextStyle(color: AppColors.danger, fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          _buildInputField(
            controller: _userCtrl,
            hint: AppStrings.loginUsernameHint,
            icon: Icons.person_outline,
            onChanged: () => setState(() => _error = null),
            onSubmit: _handleLogin,
          ),
          const SizedBox(height: 12),
          _buildInputField(
            controller: _passCtrl,
            hint: AppStrings.loginPasswordHint,
            icon: Icons.lock_outline,
            obscure: !_showPass,
            onChanged: () => setState(() => _error = null),
            onSubmit: _handleLogin,
            suffix: IconButton(
              icon: Icon(_showPass ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 18, color: AppColors.textExtraMuted),
              onPressed: () => setState(() => _showPass = !_showPass),
            ),
          ),
          const SizedBox(height: 20),
          _buildPrimaryButton(
            label: AppStrings.loginButton,
            onTap: _handleLogin,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Expanded(child: Divider(color: AppColors.border)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(AppStrings.loginDivider, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ),
              const Expanded(child: Divider(color: AppColors.border)),
            ],
          ),
          const SizedBox(height: 16),
          _buildOutlineButton(
            label: AppStrings.loginSignupButton,
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen())),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool obscure = false,
    VoidCallback? onChanged,
    VoidCallback? onSubmit,
    Widget? suffix,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: AppColors.textExtraMuted, fontSize: 14, fontWeight: FontWeight.w400),
          prefixIcon: Icon(icon, size: 18, color: AppColors.textMuted),
          suffixIcon: suffix,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
        style: const TextStyle(color: AppColors.text, fontSize: 14),
        onChanged: (_) => onChanged?.call(),
        onSubmitted: (_) => onSubmit?.call(),
      ),
    );
  }

  Widget _buildPrimaryButton({required String label, required VoidCallback onTap}) {
    return PressScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: AppGradient.primary,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4)),
          ],
        ),
        child: Text(label, textAlign: TextAlign.center, style: const TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: AppColors.primaryText,
        )),
      ),
    );
  }

  Widget _buildOutlineButton({required String label, required VoidCallback onTap}) {
    return PressScale(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.4), width: 1.5),
        ),
        child: Text(label, textAlign: TextAlign.center, style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        )),
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.science_outlined, size: 12, color: AppColors.textExtraMuted),
        const SizedBox(width: 6),
        Text(AppStrings.developedBy, style: TextStyle(fontSize: 11, color: AppColors.textExtraMuted)),
      ],
    );
  }
}
