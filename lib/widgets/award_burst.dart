import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/constants/strings.dart';

class AwardBurst extends StatefulWidget {
  final VoidCallback onDone;

  const AwardBurst({super.key, required this.onDone});

  @override
  State<AwardBurst> createState() => _AwardBurstState();
}

class _AwardBurstState extends State<AwardBurst> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    _controller.forward();
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) widget.onDone();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const stars = AppStrings.awardStars;
    return Stack(
      children: [
        for (var i = 0; i < stars.length; i++)
          AnimatedBuilder(
            animation: _controller,
            builder: (_, v) {
              final rad = (i / stars.length) * 360 * 3.14159 / 180;
              final progress = _controller.value;
              final dx = progress * (rad).floor() % 110;
              final dy = -progress * 140;
              return Positioned(
                bottom: 80,
                left: MediaQuery.of(context).size.width / 2 - 10,
                child: Transform.translate(
                  offset: Offset(dx * progress, dy * progress),
                  child: Opacity(
                    opacity: 1 - progress,
                    child: Text(stars[i], style: const TextStyle(fontSize: 24)),
                  ),
                ),
              );
            },
          ),
        Positioned(
          bottom: 60,
          left: 0,
          right: 0,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (_, v) {
              final opacity = _controller.value < 0.2 ? _controller.value / 0.2 : (1 - _controller.value) / 0.8;
              return Opacity(
                opacity: opacity.clamp(0.0, 1.0),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 100),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF9C3),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 8),
                    ],
                  ),
                  child: const Text(AppStrings.awardToast, textAlign: TextAlign.center, style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF92400E),
                    fontFamily: 'Fredoka',
                  )),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
