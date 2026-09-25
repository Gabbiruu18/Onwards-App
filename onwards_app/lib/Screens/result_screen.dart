//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class ResultScreen extends StatefulWidget {
  final String roadmapText;

  const ResultScreen({super.key, required this.roadmapText});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Action Map'),
        centerTitle: true,
        foregroundColor: Color(0xFFFFFFFF),
        backgroundColor: Color(0xFF2354B1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        // WE REPLACED Text() WITH MarkdownBody()
        child: MarkdownBody(
          data: roadmapText,
          styleSheet: MarkdownStyleSheet(
            h2: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(
                0xFF2354B1)),
            p: const TextStyle(fontSize: 16, height: 1.5, color: Color(0xFF2354B1)),
            listBullet: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    throw UnimplementedError();
  }
}