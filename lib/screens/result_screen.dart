import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';
import 'home_screen.dart';

class ResultScreen extends StatelessWidget {
  final int score;

  const ResultScreen({super.key, required this.score});

  String _getBadge() {
    if (score >= 8) return 'Gold Badge 🏆';
    if (score >= 5) return 'Silver Badge 🥈';
    if (score >= 3) return 'Bronze Badge 🥉';
    return 'Try Again! 💪';
  }

  Color _getBadgeColor() {
    if (score >= 8) return Colors.amber;
    if (score >= 5) return Colors.grey[400]!;
    if (score >= 3) return Colors.brown[300]!;
    return QuizAppTheme.primaryColor;
  }

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
                Text(
                  'Quiz Complete!',
                  style: Theme.of(context).textTheme.displayLarge,
                ).animate().fadeIn(duration: 500.ms),
                const SizedBox(height: 32),
                Card(
                  elevation: 8,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      children: [
                        Text(
                          'Your Score',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '$score',
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: _getBadgeColor(),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          _getBadge(),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: _getBadgeColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().scale(duration: 500.ms),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const HomeScreen()),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: const Icon(Icons.replay),
                  label: const Text('Play Again'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(250, 60),
                  ),
                ).animate().slideY(begin: 1, end: 0, duration: 500.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}