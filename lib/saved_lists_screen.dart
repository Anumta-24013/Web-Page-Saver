import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'view_page_screen.dart';

class SavedPagesScreen extends StatefulWidget {
  const SavedPagesScreen({Key? key}) : super(key: key);

  @override
  State<SavedPagesScreen> createState() => _SavedPagesScreenState();
}

class _SavedPagesScreenState extends State<SavedPagesScreen> {
  List<Map<String, dynamic>> savedPages = [];

  @override
  void initState() {
    super.initState();
    _loadSavedPages();
  }

  Future<void> _loadSavedPages() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/saved_pages.json');
    if (await file.exists()) {
      final content = await file.readAsString();
      if (content.isNotEmpty) {
        final List<dynamic> data = jsonDecode(content);
        setState(() {
          savedPages = List<Map<String, dynamic>>.from(data);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Saved Pages List", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: savedPages.isEmpty
          ? const Center(child: Text("No saved pages yet"))
          : ListView.builder(
        itemCount: savedPages.length,
        itemBuilder: (context, index) {
          final page = savedPages[index];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              leading: const Icon(Icons.insert_drive_file, color: Colors.blueAccent),
              title: Text(page['title']),
              subtitle: Text("Size: ${page['size']} KB"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewPageScreen(
                      title: page['title'],
                      filePath: page['path'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
