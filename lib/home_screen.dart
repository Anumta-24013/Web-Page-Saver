import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.home, color: Colors.white),
            SizedBox(width: 8),
            Text('HOME', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(
              context,
              icon: Icons.download,
              label: 'SAVE Page',
              route: '/save',
            ),
            const SizedBox(height: 25),
            _buildButton(
              context,
              icon: Icons.check_circle_outline,
              label: 'Saved List',
              route: '/savedlist',
            ),
            const SizedBox(height: 25),
            _buildButton(
              context,
              icon: Icons.settings,
              label: 'Settings',
              route: '/settings',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context,
      {required IconData icon, required String label, required String route}) {
    return ElevatedButton.icon(
      onPressed: () => Navigator.pushNamed(context, route),
      icon: Icon(icon, color: Colors.white, size: 28),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0D47A1), // same deep blue
        minimumSize: const Size(250, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
