import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/theme/app_colors.dart';

enum TopicId {
  addition,
  subtraction,
  multiplication,
  division,
  geometry,
  data,
  algebra;

  Color get color => AppColors.topicColors[name]!;
}

class Topic {
  final TopicId id;
  final String name;
  final String subname;
  final IconData icon;

  const Topic({
    required this.id,
    required this.name,
    required this.subname,
    required this.icon,
  });
}
