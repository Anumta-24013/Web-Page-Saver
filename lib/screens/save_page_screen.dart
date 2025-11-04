import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as dom;
import 'package:uuid/uuid.dart';
import 'package:hive/hive.dart';
import 'package:mad_project/models/save_page.dart';
import 'page_view_screen.dart';

class SavePageScreen extends StatefulWidget {
  const SavePageScreen({Key? key}) : super(key: key);

  @override
  State<SavePageScreen> createState() => _SavePageScreenState();
}

class _SavePageScreenState extends State<SavePageScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _isLoading = false;

  Future<void> _startDownload() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final response = await Dio().get(
        url,
        options: Options(
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
          responseType: ResponseType.plain,
          followRedirects: true,
          validateStatus: (status) => status! < 500,
        ),
      );

      if (response.statusCode == 200) {
        String htmlContent = response.data;
        final dir = await getApplicationDocumentsDirectory();
        final pageFolder = Directory('${dir.path}/page_${DateTime.now().millisecondsSinceEpoch}');
        await pageFolder.create();

        dom.Document document = html_parser.parse(htmlContent);

        // Remove all images (optional, since you want text-only)
        document.getElementsByTagName('img').forEach((img) => img.remove());

        final updatedHtml = document.outerHtml;
        final htmlFile = File('${pageFolder.path}/index.html');
        await htmlFile.writeAsString(updatedHtml);

        final titleElement = document.getElementsByTagName('title');
        final pageTitle = titleElement.isNotEmpty ? titleElement.first.text : 'Untitled';

        final box = Hive.box<SavedPage>('savedPages');
        final page = SavedPage(
          id: const Uuid().v4(),
          title: pageTitle,
          url: url,
          localPath: htmlFile.path,
          savedDate: DateTime.now(),
        );
        await box.add(page);

        setState(() => _isLoading = false);

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Download Complete'),
            content: const Text('Page saved successfully.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PageViewScreen(filePath: htmlFile.path),
                    ),
                  );
                },
                child: const Text('Open'),
              ),
            ],
          ),
        );
      } else {
        throw Exception('Failed to load page');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Save Page')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: const InputDecoration(
                labelText: 'Enter Web Page URL',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _startDownload,
              child: const Text('Download & Save'),
            ),
            const SizedBox(height: 16),
            if (_isLoading) const LinearProgressIndicator(),
          ],
        ),
      ),
    );
  }
}