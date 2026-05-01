import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String playerName;
  ProfileScreen({required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Player Profile"), backgroundColor: Colors.pinkAccent),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30),
            CircleAvatar(radius: 50, child: Icon(Icons.person, size: 50)),
            Text(playerName, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Divider(indent: 50, endIndent: 50),
            // Example of static stat cards
            _buildStatCard("Total Wins", "12"),
            _buildStatCard("Best Time", "24s"),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Card(
      margin: EdgeInsets.all(10),
      child: ListTile(title: Text(title), trailing: Text(value)),
    );
  }
}