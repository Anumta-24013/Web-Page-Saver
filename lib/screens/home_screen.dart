import 'package:flutter/material.dart';
import 'save_page_screen.dart';
import 'saved_list_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatelessWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const HomeScreen({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Page Saver'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SavePageScreen()));
              },
              child: const Text('Save Page'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const SavedListScreen()));
              },
              child: const Text('Saved List'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => SettingsScreen(
                      isDarkMode: isDarkMode,
                      onThemeChanged: onThemeChanged,
                    )));
              },
              child: const Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}