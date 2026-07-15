import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/constants/strings.dart';
import 'package:ganitbondhu_app/models/message.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';
import 'package:ganitbondhu_app/theme/app_styles.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == MessageRole.user;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      builder: (_, v, child) => Opacity(
        opacity: v,
        child: Transform.translate(
          offset: Offset(0, 14 * (1 - v)),
          child: _buildBubble(isUser),
        ),
      ),
    );
  }

  Widget _buildBubble(bool isUser) {
    return Column(
      crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        if (!isUser)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 22, height: 22,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primaryLight, AppColors.primaryLight.withValues(alpha: 0.3)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.psychology, size: 12, color: AppColors.primary),
                ),
                const SizedBox(width: 6),
                Text(AppStrings.chatAiName, style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textMuted,
                )),
              ],
            ),
          ),
        Container(
          constraints: const BoxConstraints(maxWidth: 300),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isUser ? AppColors.primary : AppColors.surface,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(18),
              topRight: const Radius.circular(18),
              bottomLeft: isUser ? const Radius.circular(18) : const Radius.circular(6),
              bottomRight: isUser ? const Radius.circular(6) : const Radius.circular(18),
            ),
            border: isUser ? null : Border.all(color: AppColors.borderLight),
            boxShadow: isUser
                ? [BoxShadow(color: AppColors.primary.withValues(alpha: 0.15), blurRadius: 8, offset: const Offset(0, 3))]
                : [AppShadow.card],
          ),
          child: Text(
            message.text,
            style: TextStyle(
              fontSize: 14,
              color: isUser ? Colors.white : AppColors.text,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}
