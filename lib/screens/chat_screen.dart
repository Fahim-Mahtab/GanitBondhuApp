import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ganitbondhu_app/constants/strings.dart';
import 'package:ganitbondhu_app/models/message.dart';
import 'package:ganitbondhu_app/models/subtopic.dart';
import 'package:ganitbondhu_app/models/topic.dart';
import 'package:ganitbondhu_app/providers/app_state_provider.dart';
import 'package:ganitbondhu_app/screens/same_level_screen.dart';
import 'package:ganitbondhu_app/screens/login_screen.dart';
import 'package:ganitbondhu_app/services/math_data.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/theme/app_styles.dart';
import 'package:ganitbondhu_app/widgets/page_shell.dart';
import 'package:ganitbondhu_app/widgets/top_bar.dart';
import 'package:ganitbondhu_app/widgets/logout_button.dart';
import 'package:ganitbondhu_app/widgets/back_button.dart';
import 'package:ganitbondhu_app/widgets/award_burst.dart';
import 'package:ganitbondhu_app/widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  final Topic topic;
  final Subtopic subtopic;

  const ChatScreen({super.key, required this.topic, required this.subtopic});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _inputCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  final _messages = <Message>[];
  bool _loading = false;
  bool _started = false;
  bool _recording = false;
  bool _showAward = false;
  bool _mastered = false;
  int _points = 0;

  @override
  void dispose() {
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) _scrollCtrl.animateTo(_scrollCtrl.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
    });
  }

  void _start() {
    setState(() => _loading = true);
    _started = true;
    Future.delayed(const Duration(seconds: 1), () {
      if (!mounted) return;
      final mode = context.read<AppStateProvider>().mode;
      final key = mode == AppMode.learning ? 'start_learning' : 'start_practice';
      final raw = MathData.getRandomResponse(key);
      setState(() {
        _messages.add(Message(role: MessageRole.ai, text: raw.replaceAll('[[AWARD=1]]', '').trim()));
        _loading = false;
      });
      _scrollToBottom();
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    setState(() {
      _messages.add(Message(role: MessageRole.user, text: text));
      _loading = true;
    });
    _inputCtrl.clear();
    _scrollToBottom();

    Future.delayed(Duration(milliseconds: 1200 + Random().nextInt(800)), () {
      if (!mounted) return;
      final raw = MathData.getRandomResponse('default');
      final hasAward = raw.contains('[[AWARD=1]]');
      setState(() {
        _messages.add(Message(
          role: MessageRole.ai,
          text: raw.replaceAll('[[AWARD=1]]', '').trim(),
          award: hasAward,
        ));
        _loading = false;
        if (hasAward) {
          _showAward = true;
          _points++;
          if (_points >= 3 && !_mastered) _mastered = true;
        }
      });
      _scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppStateProvider>();
    final mode = state.mode;
    final modeColor = mode == AppMode.learning ? AppColors.learn : AppColors.practice;
    final modeLabel = mode == AppMode.learning ? AppStrings.chatLearningMode : AppStrings.chatPracticeMode;

    return PageShell(
      child: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                TopBar(
                  left: AppBackButton(label: AppStrings.chatBackLabel, onTap: () => Navigator.pop(context)),
                  title: widget.topic.name,
                  subtitle: modeLabel,
                  right: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.practiceLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(AppStrings.chatPoints(_points),
                          style: const TextStyle(fontFamily: 'Fredoka', fontSize: 13, fontWeight: FontWeight.w700, color: AppColors.practice)),
                      ),
                      const SizedBox(width: 6),
                      LogoutButton(onTap: () => Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (_) => const LoginScreen()), (_) => false,
                      )),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.bg,
                    child: _started ? _buildChat(modeColor) : _buildWelcome(modeColor),
                  ),
                ),
                if (_started) _buildInputBar(modeColor),
              ],
            ),
          ),
          if (_showAward) AwardBurst(onDone: () => setState(() => _showAward = false)),
        ],
      ),
    );
  }

  Widget _buildWelcome(Color modeColor) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 88, height: 88,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryLight, AppColors.primaryLight.withValues(alpha: 0.3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 2),
                boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.1), blurRadius: 20, offset: const Offset(0, 4))],
              ),
              child: const Center(child: Text('🤖', style: TextStyle(fontSize: 40))),
            ),
            const SizedBox(height: 20),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
              ).createShader(bounds),
              child: const Text(AppStrings.chatWelcomeHeading, style: TextStyle(
                fontFamily: 'Fredoka',
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              )),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.chatWelcomeSubtitle(widget.subtopic.name, context.read<AppStateProvider>().mode == AppMode.learning ? AppStrings.chatWelcomeLearning : AppStrings.chatWelcomePractice),
              style: const TextStyle(fontSize: 13, color: AppColors.textMuted),
            ),
            const SizedBox(height: 28),
            _buildGradientButton(
              label: AppStrings.chatStartButton,
              color: modeColor,
              onTap: _start,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChat(Color modeColor) {
    return ListView(
      controller: _scrollCtrl,
      padding: const EdgeInsets.all(16),
      children: [
        ..._messages.map((msg) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: ChatBubble(message: msg),
        )),
        if (_loading) _buildLoadingBubble(),
        if (_mastered && !_loading) _buildMasteryCard(),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildLoadingBubble() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 28, height: 28,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primaryLight, AppColors.primaryLight.withValues(alpha: 0.3)],
              ),
              shape: BoxShape.circle,
            ),
            child: const Center(child: Icon(Icons.psychology, size: 14, color: AppColors.primary)),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16),
                bottomRight: Radius.circular(16), bottomLeft: Radius.circular(4),
              ),
              border: Border.all(color: AppColors.border),
              boxShadow: [AppShadow.card],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(3, (i) => _bouncingDot(i)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bouncingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      builder: (_, v, child) {
        final bounce = sin(v * pi * 2 + index * 2.0) * 0.5 + 0.5;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: Transform.translate(
            offset: Offset(0, -bounce * 4),
            child: Container(
              width: 8, height: 8,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: bounce * 0.7 + 0.3),
                shape: BoxShape.circle,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMasteryCard() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 400),
      builder: (_, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, 14 * (1 - v)),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.learnLight, AppColors.learnLight.withValues(alpha: 0.5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.learn.withValues(alpha: 0.3), width: 1.5),
              boxShadow: [BoxShadow(color: AppColors.learn.withValues(alpha: 0.1), blurRadius: 12, offset: const Offset(0, 4))],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.flag, size: 16, color: AppColors.learn),
                    const SizedBox(width: 8),
                    const Text(AppStrings.chatMasteryTitle, style: TextStyle(
                      fontFamily: 'Fredoka',
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.learn,
                    )),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(AppStrings.chatMasteryPrompt, style: TextStyle(fontSize: 12, color: AppColors.textSub)),
                const SizedBox(height: 12),
                _buildGradientButton(
                  label: AppStrings.chatMasteryButton,
                  color: AppColors.learn,
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SameLevelScreen(topic: widget.topic, subtopic: widget.subtopic))),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(AppStrings.chatMasteryFootnote, style: TextStyle(fontSize: 11, color: AppColors.textMuted)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputBar(Color modeColor) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(color: AppColors.shadowLight, blurRadius: 8, offset: const Offset(0, -2)),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.bg,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: TextField(
                controller: _inputCtrl,
                decoration: InputDecoration(
                  hintText: AppStrings.chatInputHint,
                  hintStyle: TextStyle(color: AppColors.textExtraMuted, fontSize: 13),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10),
                ),
                style: const TextStyle(color: AppColors.text, fontSize: 14),
                onSubmitted: _sendMessage,
              ),
            ),
          ),
          const SizedBox(width: 8),
          _buildIconButton(
            icon: _recording ? Icons.mic_off : Icons.mic,
            active: _recording,
            activeColor: AppColors.danger,
            onTap: () => setState(() => _recording = !_recording),
          ),
          const SizedBox(width: 8),
          _buildSendButton(),
        ],
      ),
    );
  }

  Widget _buildIconButton({
    required IconData icon,
    required bool active,
    required Color activeColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44, height: 44,
        decoration: BoxDecoration(
          color: active ? activeColor.withValues(alpha: 0.1) : AppColors.bg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: active ? activeColor.withValues(alpha: 0.3) : AppColors.borderLight),
        ),
        child: Icon(icon, size: 18, color: active ? activeColor : AppColors.textMuted),
      ),
    );
  }

  Widget _buildSendButton() {
    final canSend = !_loading && _inputCtrl.text.trim().isNotEmpty;
    return GestureDetector(
      onTap: canSend ? () => _sendMessage(_inputCtrl.text) : null,
      child: Container(
        width: 44, height: 44,
        decoration: BoxDecoration(
          gradient: canSend ? AppGradient.primary : LinearGradient(
            colors: [AppColors.border, AppColors.borderLight],
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: canSend ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 3))] : null,
        ),
        child: Center(
          child: _loading
            ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : Icon(Icons.send_rounded, size: 17, color: canSend ? Colors.white : AppColors.textExtraMuted),
        ),
      ),
    );
  }

  Widget _buildGradientButton({required String label, required Color color, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [color, color.withValues(alpha: 0.8)], begin: Alignment.centerLeft, end: Alignment.centerRight),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.3), blurRadius: 12, offset: const Offset(0, 4))],
        ),
        child: Text(label, textAlign: TextAlign.center, style: const TextStyle(
          fontFamily: 'Fredoka',
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        )),
      ),
    );
  }
}
