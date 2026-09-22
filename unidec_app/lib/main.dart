import 'package:flutter/material.dart';
import 'package:unidec_app/AI Service/ai_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(const DecisionGuardianApp());
}

class DecisionGuardianApp extends StatelessWidget {
  const DecisionGuardianApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Decision Guardian',
      debugShowCheckedModeBanner: false,
      // 1. Sleek Modern Dark Theme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212), // Deep premium black
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

// --- NEW CODE: Add this below your HomeScreen class ---

// 1. The Blueprint for a Question
class FilterQuestion {
  final String prompt;
  final List<String> choices;

  FilterQuestion({required this.prompt, required this.choices});
}

// 2. The Question Screen
class QuestionScreen extends StatefulWidget {
  final String userDilemma;

  // This screen needs to know what the user typed on the first screen
  const QuestionScreen({super.key, required this.userDilemma});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  // A temporary list of hardcoded questions to test the UI
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
  List<String> _userAnswers = [];
  bool _isLoading = false; // NEW: Keeps track of when the AI is thinking


  // 3. What happens when a user taps an answer
  void _selectAnswer(String answer) {
    setState(() {
      _userAnswers.add(answer);

      if (_currentQuestionIndex < _questions.length - 1) {
        // Move to the next question
        _currentQuestionIndex++;
      } else {
        // We reached the end! Show the final results
        _showFinalSummary();
      }
    });
  }

// REPLACE the old _showFinalSummary with this:
  Future<void> _showFinalSummary() async {
    setState(() {
      _isLoading = true; // Turn on the loading spinner
    });

    // 1. Send the dilemma and answers to Gemini
    final aiResponse = await AIService.generateRoadmap(
      widget.userDilemma,
      _userAnswers,
    );

    // 2. Turn off the loading spinner
    setState(() {
      _isLoading = false;
    });

    // 3. Jump to the final Result Screen
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
      ),
      // REPLACE the body of QuestionScreen with this:
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
              style: const TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // The Question Text
            Text(
              currentQuestion.prompt,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // 4. Generate a button for every choice in the list
            ...currentQuestion.choices.map((choice) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: OutlinedButton(
                  onPressed: () => _selectAnswer(choice),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: const BorderSide(color: Colors.deepPurple),
                  ),
                  child: Text(
                    choice,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _decisionController = TextEditingController();

  @override
  void dispose() {
    _decisionController.dispose();
    super.dispose();
  }

  void _submitDilemma() {
    final String userText = _decisionController.text.trim();

    if (userText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please tell the Guardian your dilemma first!'),
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuestionScreen(userDilemma: userText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 2. The Hero Icon
                const Icon(
                  Icons.shield_moon_outlined, // A cool Guardian icon
                  size: 80,
                  color: Colors.cyanAccent,
                ),
                const SizedBox(height: 24),

                // 3. The Title
                const Text(
                  'Decision Guardian',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'What are you facing today?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // 4. The Elevated Input Card
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E1E1E),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.cyanAccent.withOpacity(0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _decisionController,
                    maxLines: 5,
                    style: const TextStyle(fontSize: 16, height: 1.5),
                    decoration: InputDecoration(
                      hintText: 'e.g., I want to start a food business, but I have a small budget...',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(20),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // 5. The Premium Action Button
                ElevatedButton(
                  onPressed: _submitDilemma,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent.shade700,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    elevation: 5,
                    shadowColor: Colors.cyanAccent.withOpacity(0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Analyze Decision',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// --- NEW SCREEN: Add to the bottom of main.dart ---
class ResultScreen extends StatelessWidget {
  final String roadmapText;

  const ResultScreen({super.key, required this.roadmapText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Action Map'),
        backgroundColor: Colors.deepPurple.shade100,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        // WE REPLACED Text() WITH MarkdownBody()
        child: MarkdownBody(
          data: roadmapText,
          styleSheet: MarkdownStyleSheet(
            h2: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            p: const TextStyle(fontSize: 16, height: 1.5),
            listBullet: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}