//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unidec_app/Screens/question_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
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
          content: const Text('Please tell the Uni your dilemma first!'),
          backgroundColor: Color(0xFFE1E1E1),
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
    _decisionController.clear();
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
                const Icon(
                  Icons.handshake_outlined,
                  size: 80,
                  color: Color(0xFF2354B1),
                ),
                const SizedBox(height: 24),
                const Text(
                  'UniDec',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  'How can we help you today?',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4E4E4),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _decisionController,
                    maxLines: 5,
                    style: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFF003284)),
                    decoration: InputDecoration(
                      hintText: 'e.g., I want to start a food business, but I have a small budget...',
                      hintStyle: TextStyle(color: Color(0xFF000000).withAlpha(100)),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(20),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _submitDilemma,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF2354B1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    elevation: 5,
                    shadowColor: Colors.cyanAccent.withValues(alpha: 0.5),
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