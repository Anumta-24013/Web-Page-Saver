import 'package:flutter/material.dart';
import 'feedback_screen.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SettingsScreen({
    Key? key,
    required this.isDarkMode,
    required this.onThemeChanged,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isDark;

  @override
  void initState() {
    super.initState();
    _isDark = widget.isDarkMode;
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).colorScheme.primary;
    const Color settingsIconColor = Colors.deepPurple;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            _buildSettingsCard(
              context,
              children: [
                _buildThemeTile(
                  primaryColor: primaryColor,
                  isDark: _isDark,
                  onToggle: (value) {
                    setState(() {
                      _isDark = value;
                    });
                    widget.onThemeChanged(value);
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingsCard(
              context,
              children: [
                _buildSettingTile(
                  leadingIcon: Icons.feedback_outlined,
                  leadingColor: settingsIconColor,
                  title: "Feedback",
                  subtitle: "Send us your thoughts and ratings",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FeedbackScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1),
                _buildSettingTile(
                  leadingIcon: Icons.info_outline,
                  leadingColor: settingsIconColor,
                  title: "About",
                  subtitle: "Learn more about this app",
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: "Web Page Saver",
                      applicationVersion: "1.0.0",
                      children: const [
                        Text(
                          "This app allows you to save, manage, and view web pages offline.\n\n"
                              "Developed by: Team Web Page Saver",
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildSettingsCard(
              context,
              children: [
                _buildSettingTile(
                  leadingIcon: Icons.delete_outline,
                  leadingColor: settingsIconColor,
                  title: "Trash",
                  subtitle: "View deleted pages",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("🗑 Trash screen not added yet")),
                    );
                  },
                ),
                const Divider(height: 1),
                _buildSettingTile(
                  leadingIcon: Icons.delete_forever,
                  leadingColor: Colors.redAccent,
                  title: "Remove All",
                  subtitle: "Remove all saved pages",
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("⚠️ Remove All feature coming soon"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingTile({
    required IconData leadingIcon,
    required Color leadingColor,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Widget? trailing,
  }) {
    return ListTile(
      leading: Icon(leadingIcon, color: leadingColor),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subtitle),
      trailing: trailing,
      onTap: onTap,
    );
  }

  Widget _buildSettingsCard(BuildContext context, {required List<Widget> children}) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: children),
    );
  }

  Widget _buildThemeTile({
    required Color primaryColor,
    required bool isDark,
    required Function(bool) onToggle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
      child: Row(
        children: [
          Icon(isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined, color: primaryColor),
          const SizedBox(width: 28),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Theme", style: TextStyle(fontWeight: FontWeight.w500)),
                Text(isDark ? "Dark Mode Activated" : "Light Mode Activated",
                    style: Theme.of(context).textTheme.bodySmall),
              ],
            ),
          ),
          Switch(
            value: isDark,
            activeThumbColor: Theme.of(context).colorScheme.secondary.withOpacity(0.7),
            onChanged: onToggle,
          ),
        ],
      ),
    );
  }
}
