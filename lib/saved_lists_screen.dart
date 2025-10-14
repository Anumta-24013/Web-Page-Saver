import 'package:flutter/material.dart';

class SavedListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('✅ Saved List')),
      body: const Center(
        child: Text(
          'This is the Saved List screen.\n(Feature by Member 2)',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
