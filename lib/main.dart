import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saved Pages App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 2,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      home: const SavedPagesScreen(), // Start with saved pages list
    );
  }
}

class SavedPagesScreen extends StatefulWidget {
  const SavedPagesScreen({Key? key}) : super(key: key);

  @override
  State<SavedPagesScreen> createState() => _SavedPagesScreenState();
}

class _SavedPagesScreenState extends State<SavedPagesScreen> {
  // Dummy data for demonstration
  List<Map<String, dynamic>> savedPages = [
    {"title": "News", "size": 120, "date": DateTime(2025, 10, 10)},
    {"title": "TechCrunch", "size": 95, "date": DateTime(2025, 10, 8)},
    {"title": "Notes", "size": 80, "date": DateTime(2025, 10, 5)},
    {"title": "Food Blog", "size": 150, "date": DateTime(2025, 10, 12)},
    {"title": "WanderWorld", "size": 60, "date": DateTime(2025, 10, 3)},
    {"title": "Healthy Lifestyle Tips", "size": 110, "date": DateTime(2025, 10, 9)},
    {"title": "Pakistan Studies", "size": 130, "date": DateTime(2025, 10, 6)},
  ];

  String searchQuery = '';
  String sortBy = 'Date'; // Default sorting method

  @override
  Widget build(BuildContext context) {
    // Filter pages by search query
    List<Map<String, dynamic>> filteredPages = savedPages
        .where((page) =>
        page['title'].toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    // Apply sorting method
    if (sortBy == 'Size') {
      filteredPages.sort((a, b) => a['size'].compareTo(b['size']));
    } else if (sortBy == 'Alphabetically') {
      filteredPages.sort((a, b) => a['title'].compareTo(b['title']));
    } else if (sortBy == 'Date') {
      filteredPages.sort((a, b) => b['date'].compareTo(a['date']));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Saved Pages List",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue[800],
        actions: [
          // Sort Button (Top Right)
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() => sortBy = value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "Size", child: Text("Sort by Size")),
              const PopupMenuItem(
                  value: "Alphabetically", child: Text("Sort Alphabetically")),
              const PopupMenuItem(value: "Date", child: Text("Sort by Date")),
            ],
            icon: const Icon(Icons.sort),
          ),
        ],
      ),

      // Main Body
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),

          // List of Saved Pages
          Expanded(
            child: ListView.builder(
              itemCount: filteredPages.length,
              itemBuilder: (context, index) {
                final page = filteredPages[index];
                return Card(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  elevation: 3,
                  child: ListTile(
                    leading: const Icon(Icons.insert_drive_file,
                        color: Colors.blueAccent),
                    title: Text(
                      page['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16),
                    ),
                    subtitle: Text(
                        "Size: ${page['size']} KB  |  Date: ${page['date'].toLocal().toString().split(' ')[0]}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Opening '${page['title']}'..."),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
