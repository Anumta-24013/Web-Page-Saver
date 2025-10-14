import 'package:flutter/material.dart';
import 'save_page_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Web Page Saver',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SavePageScreen(),
    );
  }
}
