import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unidec_app/Screens/result_screen.dart';
import 'package:unidec_app/main.dart';

import 'package:unidec_app/AI_Service/ai_service.dart';

class QuestionScreen extends StatefulWidget {
  final String userDilemma;
  const QuestionScreen({super.key, required this.userDilemma});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final List<FilterQuestion> _questions = [
    FilterQuestion(
      prompt: "How urgent is this decision?",
      choices: ["Extremely Urgent (Today)", "Within a week", "No rush"],
    ),
    FilterQuestion(
      prompt: "Does this require a significant amount of money?",
      choices: ["Yes, high cost", "A little bit", "No cost at all"],
    ),
    FilterQuestion(
      prompt: "Is this choice easy to reverse if you change your mind?",
      choices: ["Yes, very easy", "Somewhat", "No, it's permanent"],
    ),
  ];

  int _currentQuestionIndex = 0;
  final List<String> _userAnswers = [];
  bool _isLoading = false;


  void _selectAnswer(String answer) {
    setState(() {
      _userAnswers.add(answer);
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
      } else {
        _showFinalSummary();
      }
    });
  }

  Future<void> _showFinalSummary() async {
    setState(() {
      _isLoading = true;
    });

    final aiResponse = await AIService.generateRoadmap(
      widget.userDilemma,
      _userAnswers,
    );

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(roadmapText: aiResponse),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gathering Context'),
        centerTitle: true,
        foregroundColor: Color(0xFF2354B1),
        backgroundColor: Color(0xFFDBDBDB),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _isLoading
            ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text("The Guardian is analyzing your decision..."),
            ],
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Question Progress Counter
            Text(
              'Question ${_currentQuestionIndex + 1} of ${_questions.length}',
              style: const TextStyle(color: Color(0xFF003284), fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              currentQuestion.prompt,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF003284)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            ...currentQuestion.choices.map((choice) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: OutlinedButton(
                  onPressed: () => _selectAnswer(choice),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Color(0xFFCDCDCD),
                    side: const BorderSide(color: Color(0xFF003284)),
                  ),
                  child: Text(
                    choice,
                    style: TextStyle(fontSize: 16, color: Color(0xFF003284)),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class FilterQuestion {
  final String prompt;
  final List<String> choices;

  FilterQuestion({required this.prompt, required this.choices});
}