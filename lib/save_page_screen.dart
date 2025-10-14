import 'package:flutter/material.dart';

class SavePageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('⬇️ Save Page')),
      body: const Center(
        child: Text(
          'This is the Save Page screen.\n(Feature by Member 1)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
