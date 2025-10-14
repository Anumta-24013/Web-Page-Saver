import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SavePageScreen(),
    );
  }
}

class SavePageScreen extends StatefulWidget {
  const SavePageScreen({super.key});

  @override
  State<SavePageScreen> createState() => _SavePageScreenState();
}

class _SavePageScreenState extends State<SavePageScreen> {
  bool isTextChecked = false;
  bool isImageChecked = false;
  final TextEditingController _urlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _urlController.addListener(() {
      setState(() {}); // just to update button state
    });
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const blueColor = Color(0xFF1A2D8F);
    const greenColor = Color(0xFF2ECC71);

    bool isButtonEnabled = _urlController.text.trim().isNotEmpty &&
        (isTextChecked || isImageChecked);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Header
            Container(
              color: blueColor,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.download, color: Colors.white, size: 40),
                  SizedBox(width: 16),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Save Page',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 40),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // 🔹 Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _urlController,
                cursorColor: blueColor,
                decoration: InputDecoration(
                  hintText: 'Enter URL',
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear, color: Colors.grey),
                    onPressed: () {
                      _urlController.clear();
                    },
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding:
                  const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: blueColor, width: 2),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // 🔹 Checkbox boxes
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: Column(
                children: [
                  _buildBlueBox(
                    icon: Icons.text_snippet,
                    label: "Text",
                    isChecked: isTextChecked,
                    onChanged: (value) {
                      setState(() => isTextChecked = value!);
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildBlueBox(
                    icon: Icons.image,
                    label: "Image",
                    isChecked: isImageChecked,
                    onChanged: (value) {
                      setState(() => isImageChecked = value!);
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 50),

            // 🔹 Download button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton.icon(
                  onPressed: isButtonEnabled ? () {} : null,
                  icon: const Icon(Icons.download, color: Colors.white),
                  label: const Text(
                    "Download & Save",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    isButtonEnabled ? greenColor : const Color(0xFFB0B0B0),
                    disabledBackgroundColor: const Color(0xFFB0B0B0),
                    foregroundColor: Colors.white,
                    disabledForegroundColor: Colors.white70,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    elevation: 6,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Helper method to build blue check boxes
  Widget _buildBlueBox({
    required IconData icon,
    required String label,
    required bool isChecked,
    required ValueChanged<bool?> onChanged,
  }) {
    const blueColor = Color(0xFF1A2D8F);

    return Container(
      decoration: BoxDecoration(
        color: blueColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(icon, color: Colors.white),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Checkbox(
            value: isChecked,
            onChanged: onChanged,
            checkColor: blueColor,
            activeColor: Colors.white,
            side: const BorderSide(color: Colors.white, width: 2),
          ),
        ],
      ),
    );
  }
}
