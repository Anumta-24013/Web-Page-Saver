import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:html/parser.dart' as html_parser;

class SavePageScreen extends StatefulWidget {
  const SavePageScreen({super.key});

  @override
  State<SavePageScreen> createState() => _SavePageScreenState();
}

class _SavePageScreenState extends State<SavePageScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool textSelected = false;
  bool imageSelected = false;
  bool isDownloading = false;

  Future<void> _downloadAndSave() async {
    final url = _urlController.text.trim();
    if (url.isEmpty) return;

    setState(() => isDownloading = true);

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36',
        },
      );
      if (response.statusCode != 200) throw Exception("Failed to fetch page");

      final dir = await getApplicationDocumentsDirectory();
      String fileName = "page_${DateTime.now().millisecondsSinceEpoch}";
      List<String> savedFilesTemp = [];

      // ---- Save Text ----
      if (textSelected) {
        final document = html_parser.parse(response.body);
        final textContent = document.body?.text ?? "";
        final file = File('${dir.path}/$fileName.txt');
        await file.writeAsString(textContent);
        savedFilesTemp.add(file.path);
      }

      // ---- Save Images ----
      if (imageSelected) {
        final document = html_parser.parse(response.body);
        final imgTags = document.getElementsByTagName('img');
        int imgCount = 0;

        for (var img in imgTags) {
          final src = img.attributes['src'];
          if (src == null || src.isEmpty) continue;
          final uri = Uri.parse(src);
          final imgUrl = uri.isAbsolute
              ? uri.toString()
              : Uri.parse(url).resolveUri(uri).toString();

          try {
            final imgResp = await http.get(Uri.parse(imgUrl));
            if (imgResp.statusCode == 200) {
              final ext = imgUrl.split('.').last.split('?').first;
              final imgFile = File('${dir.path}/$fileName-img$imgCount.$ext');
              await imgFile.writeAsBytes(imgResp.bodyBytes);
              savedFilesTemp.add(imgFile.path);
              imgCount++;
            }
          } catch (_) {}
        }
      }

      // ---- Save Metadata to JSON ----
      if (savedFilesTemp.isNotEmpty) {
        final mainFile = File(savedFilesTemp.first);
        final stat = await mainFile.stat();

        final metadata = {
          "title": url,
          "path": savedFilesTemp.first,
          "size": (stat.size / 1024).toStringAsFixed(2),
          "date": DateTime.now().toIso8601String(),
        };
        await _savePageMetadata(metadata);

        // ---- Show Success Dialog ----
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Download Complete"),
            content: Text(
                "Saved ${savedFilesTemp.length} file(s).\nExample: ${savedFilesTemp.first}"),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("OK")),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Error"),
          content: Text("Failed to download: $e"),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK")),
          ],
        ),
      );
    }

    setState(() => isDownloading = false);
  }

  Future<void> _savePageMetadata(Map<String, dynamic> data) async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/saved_pages.json');

    List<dynamic> list = [];
    if (await file.exists()) {
      final content = await file.readAsString();
      if (content.isNotEmpty) {
        list = jsonDecode(content);
      }
    }

    list.add(data);
    await file.writeAsString(jsonEncode(list));
  }

  @override
  Widget build(BuildContext context) {
    bool isUrlEntered = _urlController.text.trim().isNotEmpty;
    bool canDownload = isUrlEntered && (textSelected || imageSelected);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Save Page", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: "Enter URL",
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilterChip(
                  label: const Text("Text"),
                  selected: textSelected,
                  onSelected: isUrlEntered ? (v) => setState(() => textSelected = v) : null,
                ),
                const SizedBox(width: 20),
                FilterChip(
                  label: const Text("Images"),
                  selected: imageSelected,
                  onSelected: isUrlEntered ? (v) => setState(() => imageSelected = v) : null,
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: canDownload && !isDownloading ? _downloadAndSave : null,
              icon: const Icon(Icons.download),
              label: Text(isDownloading ? "Downloading..." : "Download & Save"),
            ),
          ],
        ),
      ),
    );
  }
}
