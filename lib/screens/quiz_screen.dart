import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'result_screen.dart';
import '../theme/app_theme.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<dynamic> _questions = [];
  int _currentIndex = 0;
  int _score = 0;
  int _timeLeft = 10;
  Timer? _timer;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchQuizData();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _fetchQuizData() async {
    try {
      final response = await http.get(Uri.parse('https://api.jsonserve.com/Uw5CrX'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _questions = data['questions'] ?? [];
          _isLoading = false;
        });
        _startTimer();
      } else {
        throw Exception('Failed to load quiz data');
      }
    } catch (e) {
      setState(() { _isLoading = false; });
      _showErrorDialog(e.toString());
    }
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() { _timeLeft = 10; });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeLeft > 0) {
        setState(() { _timeLeft--; });
      } else { timer.cancel(); _nextQuestion(0); }
    });
  }

  void _nextQuestion(int score) {
    setState(() {
      _score += score;
      if (_currentIndex < _questions.length - 1) {
        _currentIndex++;
        _startTimer();
      } else {
        _timer?.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(score: _score)),
        );
      }
    });
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), 
            child: const Text('OK')
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return _loadingWidget();
    if (_questions.isEmpty) return _noQuestionsWidget();

    final question = _questions[_currentIndex];
    return _quizWidget(question);
  }

  Widget _loadingWidget() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(
              color: QuizAppTheme.primaryColor,
            ),
            const SizedBox(height: 20),
            Text(
              'Loading Quiz...',
              style: Theme.of(context).textTheme.titleLarge,
            )
          ],
        ),
      ),
    );
  }

  Widget _noQuestionsWidget() {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz')),
      body: const Center(child: Text('No questions available')),
    );
  }

  Widget _quizWidget(dynamic question) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${_currentIndex + 1}/${_questions.length}'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: LinearProgressIndicator(
            value: (_currentIndex + 1) / _questions.length,
            backgroundColor: Colors.white.withOpacity(0.2),
            color: QuizAppTheme.secondaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Time Left: $_timeLeft s',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  question['question'] ?? 'No question available',
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: (question['options'] as List).length,
                itemBuilder: (context, index) {
                  final option = question['options'][index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () => _nextQuestion(option['score'] ?? 0),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: QuizAppTheme.primaryColor,
                      ),
                      child: Text(
                        option['text'] ?? 'No option text',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
