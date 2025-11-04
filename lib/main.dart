import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'save_page_screen.dart';
import 'saved_lists_screen.dart';
import 'settings_screen.dart';

void main() {
  runApp(const OfflinePageSaverApp());
}

class OfflinePageSaverApp extends StatefulWidget {
  const OfflinePageSaverApp({Key? key}) : super(key: key);

  @override
  State<OfflinePageSaverApp> createState() => _OfflinePageSaverAppState();
}

class _OfflinePageSaverAppState extends State<OfflinePageSaverApp> {
  ThemeMode themeMode = ThemeMode.light;

  void toggleTheme(bool isDark) {
    setState(() {
      themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Offline Page Saver',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          color: Color(0xFF0D47A1),
          foregroundColor: Colors.white,
        ),
      ),
      home: HomeScreen(onThemeChange: toggleTheme),
      routes: {
        '/save': (context) => const SavePageScreen(),
        '/savedlist': (context) => const SavedPagesScreen(),
        '/settings': (context) => SettingsScreen(
          isDarkMode: themeMode == ThemeMode.dark,
          onThemeChanged: toggleTheme,
        ),
      },
    );
  }
}
