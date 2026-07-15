import 'package:flutter/material.dart';
import 'package:ganitbondhu_app/constants/strings.dart';

enum AppMode { learning, practice }

class AppStateProvider extends ChangeNotifier {
  String _username = AppStrings.appStateDefaultUsername;
  String _grade = '5';
  AppMode _mode = AppMode.learning;

  String get username => _username;
  String get grade => _grade;
  AppMode get mode => _mode;

  void setUsername(String value) {
    _username = value;
    notifyListeners();
  }

  void setGrade(String value) {
    _grade = value;
    notifyListeners();
  }

  void setMode(AppMode value) {
    _mode = value;
    notifyListeners();
  }
}
