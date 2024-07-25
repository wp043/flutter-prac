import 'package:flutter/material.dart';

import 'language_translator.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Language Translator',
      debugShowCheckedModeBanner: false,
      home: LanguageTranslationPage(),
    );
  }
}
