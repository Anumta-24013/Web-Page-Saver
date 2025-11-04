import 'dart:io';
import 'package:flutter/material.dart';

class ViewPageScreen extends StatelessWidget {
  final String title;
  final String filePath;

  const ViewPageScreen({
    super.key,
    required this.title,
    required this.filePath,
  });

  @override
  Widget build(BuildContext context) {
    final file = File(filePath);

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<String>(
        future: file.readAsString(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Text(
                  snapshot.data ?? "",
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
