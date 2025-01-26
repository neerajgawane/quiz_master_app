import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const QuizMasterApp());
}

class QuizMasterApp extends StatelessWidget {
  const QuizMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizMaster',
      theme: QuizAppTheme.lightTheme,
      home: const HomeScreen(),
    );
  }
}