import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ganitbondhu_app/constants/strings.dart';
import 'package:ganitbondhu_app/providers/app_state_provider.dart';
import 'package:ganitbondhu_app/screens/dashboard_screen.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/widgets/page_shell.dart';
import 'package:ganitbondhu_app/widgets/field_wrap.dart';

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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Column(
            children: [
              Column(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [                      BoxShadow(color: AppColors.primary.withValues(alpha: 0.10), blurRadius: 20, offset: const Offset(0, 4))],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.asset('assets/logo.png', width: 80, height: 80, fit: BoxFit.contain),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(AppStrings.signupTitle, style: TextStyle(
                    fontFamily: 'Fredoka',
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.text,
                  )),
                ],
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                  boxShadow: const [BoxShadow(color: Color(0x0F000000), blurRadius: 12, offset: Offset(0, 2))],
                ),
                child: Column(
                  children: [
                    const Text(AppStrings.signupCardTitle, style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.text,
                    )),
                    const SizedBox(height: 4),
                    const Text(AppStrings.signupCardSubtitle, style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textMuted,
                    )),
                    const SizedBox(height: 16),
                    FieldWrap(
                      icon: const Icon(Icons.person),
                      child: TextField(
                        controller: _nameCtrl,
                        decoration: InputDecoration(
                          hintText: AppStrings.signupNameHint,
                          filled: true,
                          fillColor: AppColors.bg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          contentPadding: const EdgeInsets.only(left: 40, right: 16, top: 14, bottom: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    FieldWrap(
                      icon: const Icon(Icons.menu_book),
                      child: DropdownButtonFormField<String>(
                        initialValue: _grade,
                        items: ['4', '5', '6', '7', '8'].map((g) => DropdownMenuItem(value: g, child: Text(AppStrings.signupClassLabel(int.parse(g))))).toList(),
                        onChanged: (v) => setState(() => _grade = v!),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.bg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          contentPadding: const EdgeInsets.only(left: 40, right: 16, top: 14, bottom: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    FieldWrap(
                      icon: const Icon(Icons.lock),
                      child: TextField(
                        controller: _passCtrl,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: AppStrings.signupPasswordHint,
                          filled: true,
                          fillColor: AppColors.bg,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: AppColors.border),
                          ),
                          contentPadding: const EdgeInsets.only(left: 40, right: 16, top: 14, bottom: 14),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.bg,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _verified,
                            onChanged: (v) => setState(() => _verified = v!),
                            activeColor: AppColors.primary,
                          ),
                          const Expanded(
                            child: Text('আমি রোবট নই', style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSub,
                            )),
                          ),
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Center(child: Text(AppStrings.signupCaptchaText, style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w700))),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleSignup,
                        child: const Text(AppStrings.signupButton, style: TextStyle(
                          fontFamily: 'Fredoka',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(AppStrings.signupBackToLogin, style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      )),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.science, size: 12, color: AppColors.textMuted),
                  const SizedBox(width: 6),
                  Text(AppStrings.developedBy, style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
