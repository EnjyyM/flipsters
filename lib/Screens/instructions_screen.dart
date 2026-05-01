import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'name_screen.dart';


class InstructionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(title: Text("How to Play"), backgroundColor: Colors.pinkAccent),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            _buildStep("1", "Pick a level (Easy, Medium, or Hard)."),
            _buildStep("2", "Flip two cards to find matching emojis."),
            _buildStep("3", "Finish before the timer hits 0 to win!"),
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.pinkAccent, minimumSize: Size(double.infinity, 50)),
              onPressed: () => Navigator.pop(context),
              child: Text("I'm Ready!", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildStep(String num, String text) {
    return ListTile(
      leading: CircleAvatar(child: Text(num)),
      title: Text(text, style: TextStyle(fontSize: 18)),
    );
  }
}