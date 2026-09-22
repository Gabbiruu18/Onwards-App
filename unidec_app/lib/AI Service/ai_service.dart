import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AIService {
  static final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  static Future<String> generateRoadmap(String dilemma, List<String> answers) async {
    if (_apiKey.isEmpty) {
      return "ERROR: The API key is missing.";
    }

    try {
      final model = GenerativeModel(
        model: 'gemini-3.6-flash',
        apiKey: _apiKey,
        // THE MASTER INSTRUCTION
        systemInstruction: Content.system('''
You are the Decision Guardian, a highly logical life assistant. 
The user will provide a dilemma and context. You must reply strictly using Markdown formatting.

Follow this exact structure:
## 1. Analysis
State the core issue (1-2 sentences).

## 2. Guardian Check
Identify any physical, financial, or emotional risks. 
If risky, write: **WARNING:** [Explain risk and suggest a safer alternative].
If safe, write: **Status: Clear to proceed safely.**

## 3. Action Roadmap
Provide a practical 3-step action plan to help the user test or navigate the situation safely. Use numbered lists.
        '''),
      );

      final prompt = '''
Dilemma: $dilemma
Context:
- ${answers.join('\n- ')}
''';

      final response = await model.generateContent([Content.text(prompt)]);
      return response.text ?? "Error generating roadmap.";

    } catch (e) {
      return "CONNECTION FAILED.\n\nDetails: $e";
    }
  }
}