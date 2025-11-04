import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:mad_project/models/save_page.dart';
import 'page_view_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class SavedListScreen extends StatefulWidget {
  const SavedListScreen({super.key});

  @override
  State<SavedListScreen> createState() => _SavedListScreenState();
}

class _SavedListScreenState extends State<SavedListScreen> {
  late Box<SavedPage> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<SavedPage>('savedPages');
  }

  void _deletePage(int index) async {
    final page = box.getAt(index);
    if (page != null) {
      final file = File(page.localPath);
      if (await file.exists()) {
        await file.delete();
      }
      await box.deleteAt(index);
      setState(() {});
    }
  }

  void _sharePage(String filePath) {
    Share.shareFiles([filePath], text: 'Check out this saved page!');
  }

  void _openPage(String filePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PageViewScreen(filePath: filePath),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = box.values.toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Pages')),
      body: pages.isEmpty
          ? const Center(child: Text('No saved pages yet.'))
          : ListView.builder(
        itemCount: pages.length,
        itemBuilder: (context, index) {
          final page = pages[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              title: Text(page.title),
              subtitle: Text(DateFormat.yMMMd().format(page.savedDate)),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'Open') {
                    _openPage(page.localPath);
                  } else if (value == 'Delete') {
                    _deletePage(index);
                  } else if (value == 'Share') {
                    _sharePage(page.localPath);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'Open', child: Text('Open')),
                  const PopupMenuItem(value: 'Share', child: Text('Share')),
                  const PopupMenuItem(value: 'Delete', child: Text('Delete')),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}