import 'package:advanced_quiz_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.quiz,
                  size: 120,
                  color: QuizAppTheme.primaryColor,
                ).animate().scale(duration: 600.ms),
                const SizedBox(height: 24),
                Text(
                  'QuizMaster',
                  style: Theme.of(context).textTheme.displayLarge,
                ).animate().fadeIn(duration: 500.ms, delay: 300.ms),
                const SizedBox(height: 16),
                Text(
                  'Challenge Your Knowledge',
                  style: Theme.of(context).textTheme.titleLarge,
                ).animate().fadeIn(duration: 500.ms, delay: 600.ms),
                const SizedBox(height: 48),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const QuizScreen()),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Start Quiz'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 60),
                  ),
                ).animate().slideY(
                  begin: 1,
                  end: 0,
                  duration: 500.ms,
                  delay: 900.ms,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
