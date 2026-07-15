import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/models/topic.dart';
import 'package:ganitbondhu_app/models/subtopic.dart';

class MathData {
  MathData._();

  static const topics = [
    Topic(id: TopicId.addition, name: 'যোগ', subname: 'Addition', icon: Icons.add),
    Topic(id: TopicId.subtraction, name: 'বিয়োগ', subname: 'Subtraction', icon: Icons.remove),
    Topic(id: TopicId.multiplication, name: 'গুণ', subname: 'Multiplication', icon: Icons.bolt),
    Topic(id: TopicId.division, name: 'ভাগ', subname: 'Division', icon: Icons.horizontal_rule),
    Topic(id: TopicId.geometry, name: 'জ্যামিতি', subname: 'Geometry', icon: Icons.category),
    Topic(id: TopicId.data, name: 'তথ্য ও সম্ভাবনা', subname: 'Data', icon: Icons.bar_chart),
    Topic(id: TopicId.algebra, name: 'বীজগণিত', subname: 'Algebra', icon: Icons.calculate),
  ];

  static const subtopics = <TopicId, List<Subtopic>>{
    TopicId.addition: [
      Subtopic(id: 's1', name: 'এক অঙ্কের যোগ', difficulty: 1),
      Subtopic(id: 's2', name: 'দুই অঙ্কের যোগ', difficulty: 2),
      Subtopic(id: 's3', name: 'তিন অঙ্কের যোগ', difficulty: 3),
      Subtopic(id: 's4', name: 'হাতের কাজ', difficulty: 3),
    ],
    TopicId.subtraction: [
      Subtopic(id: 's1', name: 'এক অঙ্কের বিয়োগ', difficulty: 1),
      Subtopic(id: 's2', name: 'দুই অঙ্কের বিয়োগ', difficulty: 2),
      Subtopic(id: 's3', name: 'ধার সহ বিয়োগ', difficulty: 3),
    ],
    TopicId.multiplication: [
      Subtopic(id: 's1', name: 'গুণতালিকা (১-৫)', difficulty: 1),
      Subtopic(id: 's2', name: 'গুণতালিকা (৬-১০)', difficulty: 2),
      Subtopic(id: 's3', name: 'দুই অঙ্কের গুণ', difficulty: 3),
    ],
    TopicId.division: [
      Subtopic(id: 's1', name: 'সহজ ভাগ', difficulty: 1),
      Subtopic(id: 's2', name: 'ভাগশেষ সহ ভাগ', difficulty: 2),
      Subtopic(id: 's3', name: 'দীর্ঘ ভাগ', difficulty: 3),
    ],
    TopicId.geometry: [
      Subtopic(id: 's1', name: 'মৌলিক আকার', difficulty: 1),
      Subtopic(id: 's2', name: 'ত্রিভুজ ও চতুর্ভুজ', difficulty: 2),
      Subtopic(id: 's3', name: 'ক্ষেত্রফল ও পরিসীমা', difficulty: 3),
    ],
    TopicId.data: [
      Subtopic(id: 's1', name: 'সারণি পড়া', difficulty: 1),
      Subtopic(id: 's2', name: 'চিত্রলেখ', difficulty: 2),
    ],
    TopicId.algebra: [
      Subtopic(id: 's1', name: 'অজানা রাশি', difficulty: 2),
      Subtopic(id: 's2', name: 'সমীকরণ সমাধান', difficulty: 3),
    ],
  };

  static const aiResponses = {
    'start_learning': [
      'নমস্কার! আমি গণিতবন্ধু 🤖 আজকে তোমাকে শিখতে সাহায্য করব। প্রথমে বলো তো, এই টপিক সম্পর্কে তুমি কী জানো?',
    ],
    'start_practice': [
      'চলো অনুশীলন শুরু করি! 💪 প্রথম প্রশ্ন: ৪৫ + ৩৭ = কত?',
    ],
    'default': [
      'খুব ভালো প্রশ্ন! এটা বুঝতে হলে আগে মনে করো যে... [[AWARD=1]]',
      'হ্যাঁ, একদম ঠিক বলেছ! এখন পরের ধাপে যাওয়া যাক। [[AWARD=1]]',
      'ভাবো একটু — যদি তোমার কাছে ৫টি আপেল থাকে এবং তুমি ৩টি দিয়ে দাও, তাহলে কতটি থাকবে? [[AWARD=1]]',
    ],
  };

  static String getRandomResponse(String key) {
    final pool = aiResponses[key] ?? aiResponses['default']!;
    return pool[DateTime.now().microsecondsSinceEpoch % pool.length];
  }
}
