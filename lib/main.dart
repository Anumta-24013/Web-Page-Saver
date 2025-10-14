import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'save_page_screen.dart';
import 'saved_lists_screen.dart';
import 'settings_screen.dart';

void main() {
  runApp(WebPageSaverApp());
}

class WebPageSaverApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Web Page Saver',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white, // white background
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0D47A1), // blue bar
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF0D47A1), // deep blue buttons
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30)),
            ),
            minimumSize: const Size(220, 60),
          ),
        ),
      ),
      home: HomeScreen(),
      routes: {
        '/save': (context) => SavePageScreen(),
        '/savedlist': (context) => SavedListScreen(),
        '/settings': (context) => SettingsScreen(),
      },
    );
  }
}
