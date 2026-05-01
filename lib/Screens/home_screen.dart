import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'name_screen.dart';
import 'instructions_screen.dart';
import 'settings_screen.dart';
import 'profile_screen.dart';
import 'theme_screen.dart';
import 'feedback_screen.dart';

class HomeScreen extends StatelessWidget {

  Future<void> _showBestScores(BuildContext context) async {
    // ... (Your existing _showBestScores code remains the same)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      // --- ADDING THE FLOATING BUTTON HERE ---
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.black.withOpacity(0.7),
        child: const Icon(Icons.feedback_outlined, color: Colors.white),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FeedbackScreen()),
          );
        },
      ),
      // ---------------------------------------
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/png3.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Flipster Game🤯',
                style: TextStyle(
                  fontSize: 40,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 30),

              // 1. Start Game
              SizedBox(
                width: 270,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NameScreen()),
                    );
                  },
                  child: Text('Start Game'),
                ),
              ),

              SizedBox(height: 20),

              // 2. Instructions
              SizedBox(
                width: 270,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => InstructionsScreen()),
                    );
                  },
                  child: Text('How to Play 📖'),
                ),
              ),

              SizedBox(height: 20),

              // 3. Settings
              SizedBox(
                width: 270,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SettingsScreen()),
                    );
                  },
                  child: Text('Settings'),
                ),
              ),

              const SizedBox(height: 20),

              // 4. Profile
              SizedBox(
                width: 270,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(playerName: "Player"),
                      ),
                    );
                  },
                  child: const Text("My Profile"),
                ),
              ),

              const SizedBox(height: 20),

              // 5. Theme
              SizedBox(
                width: 270,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PersonalizationScreen()),
                    );
                  },
                  child: const Text("Customize Theme"),
                ),
              ),

              SizedBox(height: 20),

              // 6. Best Scores
              SizedBox(
                width: 270,
                height: 50,
                child: ElevatedButton(
                  onPressed: () => _showBestScores(context),
                  child: Text('Best Score'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}