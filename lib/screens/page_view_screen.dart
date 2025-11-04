import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

class PageViewScreen extends StatelessWidget {
  final String filePath;
  const PageViewScreen({Key? key, required this.filePath}) : super(key: key);

  String _sanitizeHtml(String html) {
    // Remove <script> and <style> tags to avoid rendering issues
    return html
        .replaceAll(RegExp(r'<script[^>]*>.*?</script>', dotAll: true), '')
        .replaceAll(RegExp(r'<style[^>]*>.*?</style>', dotAll: true), '');
  }

  Future<String> _loadHtmlContent() async {
    final file = File(filePath);
    return await file.readAsString();
  }

  void _sharePage(BuildContext context) {
    Share.shareFiles([filePath], text: 'Check out this saved page!');
  }

  void _deletePage(BuildContext context) async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Page deleted successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved Page')),
      body: FutureBuilder<String>(
        future: _loadHtmlContent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load page'));
          } else {
            return SingleChildScrollView(
              child: Html(data: _sanitizeHtml(snapshot.data!)),
            );
          }
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => _deletePage(context),
                child: const Text('Delete'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => _sharePage(context),
                child: const Text('Share'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}