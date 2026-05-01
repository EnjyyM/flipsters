import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key}); // Resolves key parameter warning

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isMusicOn = true;
  bool isSoundEffectsOn = true;

  // Modern URL launcher implementation to fix 'launch' error
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.pinkAccent, // Matches game screen AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage("assets/images/png5.jpeg"), // Matches game background
            fit: BoxFit.cover,
            // Fixed opacity using the modern withValues method
            colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.5),
              BlendMode.darken,
            ),
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle("Audio Settings"),

            SwitchListTile(
              title: const Text("Music", style: TextStyle(color: Colors.white)),
              value: isMusicOn,
              onChanged: (val) => setState(() => isMusicOn = val),
              activeThumbColor: Colors.pinkAccent, // Fixed deprecated activeColor
            ),

            SwitchListTile(
              title: const Text("Sound Effects", style: TextStyle(color: Colors.white)),
              value: isSoundEffectsOn,
              onChanged: (val) => setState(() => isSoundEffectsOn = val),
              activeThumbColor: Colors.pinkAccent,
            ),

            const Divider(color: Colors.white54),

            _buildSectionTitle("Support"),

            // The button is now styled like your game cards/buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: SizedBox(
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: () => _launchURL("https://linkedin.com/in/enjyshalaby"),
                  icon: const Icon(Icons.link, color: Colors.white),
                  label: const Text(
                    "Connect on LinkedIn",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Matching card colors
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Matching card radius
                    ),
                  ),
                ),
              ),
            ),

            const Divider(color: Colors.white54),

            _buildSectionTitle("App Info"),
            const ListTile(
              title: Text("Version", style: TextStyle(color: Colors.white)),
              trailing: Text("1.0.1", style: TextStyle(color: Colors.white70)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(
          color: Colors.orangeAccent,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}