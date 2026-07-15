import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ganitbondhu_app/constants/strings.dart';
import 'package:ganitbondhu_app/providers/app_state_provider.dart';
import 'package:ganitbondhu_app/screens/dashboard_screen.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/theme/app_styles.dart';
import 'package:ganitbondhu_app/widgets/page_shell.dart';
import 'package:ganitbondhu_app/widgets/press_scale.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  String _grade = '5';
  bool _verified = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  void _handleSignup() {
    final provider = context.read<AppStateProvider>();
    provider.setUsername(_nameCtrl.text.trim().isEmpty ? AppStrings.signupDefaultUsername : _nameCtrl.text.trim());
    provider.setGrade(_grade);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageShell(
      gradientBg: true,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              const SizedBox(height: 16),
              _buildLogo(),
              const SizedBox(height: 28),
              _buildSignupCard(),
              const SizedBox(height: 24),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.15), blurRadius: 20, offset: const Offset(0, 6))],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/logo.png', width: 72, height: 72, fit: BoxFit.contain),
          ),
        ),
        const SizedBox(height: 10),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
          ).createShader(bounds),
          child: const Text(AppStrings.signupTitle, style: TextStyle(
            fontFamily: 'Fredoka',
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          )),
        ),
      ],
    );
  }

  Widget _buildSignupCard() {
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
          const Text(AppStrings.signupCardTitle, style: TextStyle(
            fontFamily: 'Fredoka',
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppColors.text,
          )),
          const SizedBox(height: 6),
          const Text(AppStrings.signupCardSubtitle, style: TextStyle(
            fontSize: 13,
            color: AppColors.textMuted,
          )),
          const SizedBox(height: 20),
          _buildInputField(controller: _nameCtrl, hint: AppStrings.signupNameHint, icon: Icons.person_outline),
          const SizedBox(height: 12),
          _buildDropdownField(),
          const SizedBox(height: 12),
          _buildInputField(controller: _passCtrl, hint: AppStrings.signupPasswordHint, icon: Icons.lock_outline, obscure: true),
          const SizedBox(height: 12),
          _buildCheckboxRow(),
          const SizedBox(height: 20),
          _buildPrimaryButton(label: AppStrings.signupButton, onTap: _handleSignup),
          const SizedBox(height: 12),
          PressScale(
            onTap: () => Navigator.pop(context),
            child: const Text(AppStrings.signupBackToLogin, style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            )),
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
          hintStyle: TextStyle(color: AppColors.textExtraMuted, fontSize: 14),
          prefixIcon: Icon(icon, size: 18, color: AppColors.textMuted),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
        ),
        style: const TextStyle(color: AppColors.text, fontSize: 14),
      ),
    );
  }

  Widget _buildDropdownField() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: DropdownButtonFormField<String>(
        initialValue: _grade,
        items: ['4', '5', '6', '7', '8'].map((g) => DropdownMenuItem(
          value: g,
          child: Text(AppStrings.signupClassLabel(int.parse(g)), style: const TextStyle(fontSize: 14, color: AppColors.text)),
        )).toList(),
        onChanged: (v) => setState(() => _grade = v!),
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.menu_book_outlined, size: 18, color: AppColors.textMuted),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14),
        ),
        style: const TextStyle(fontSize: 14, color: AppColors.text),
        icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textMuted),
      ),
    );
  }

  Widget _buildCheckboxRow() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Checkbox(
            value: _verified,
            onChanged: (v) => setState(() => _verified = v!),
            activeColor: AppColors.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          const Expanded(
            child: Text(AppStrings.signupCheckboxLabel, style: TextStyle(fontSize: 13, color: AppColors.textSub)),
          ),
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              gradient: AppGradient.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: const Center(child: Text(AppStrings.signupCaptchaText, style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700))),
          ),
        ],
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
          boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
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
