import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'Screens/home_screen.dart';
//import 'Screens/opening_screen.dart';

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

      title: 'UniDec',
      color: Colors.black,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueAccent,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFFDBDBDB),
        useMaterial3: true,
      ),
      //home: OpeningScreen(),
      home: const HomeScreen(),
    );
  }
}



