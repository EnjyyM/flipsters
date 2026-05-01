import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Screens/home_screen.dart';
import 'Screens/level_screen.dart';
import 'Screens/instructions_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/globals.dart' as globals;


class gameScreen extends StatefulWidget {
  final String name;
  final String level;
  final String themeId;
  gameScreen({required this.name, required this.level, required this.themeId});

  @override
  game_screen_state createState() => game_screen_state();
}

class game_screen_state extends State<gameScreen> {
  List<String> cards = [];
  List<bool> revealed = [];
  List<bool> matched = [];
  int? first_ind;
  int? sec_ind;
  bool waiting = false;
  int score = 0;
  late int timeLeft;
  Timer? _timer;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    _generateThemedCards(); // Call the new dynamic generator
    _startTimer();
  }

  // --- NEW: Dynamic Card Generator ---
  void _generateThemedCards() {
    List<String> emojiSet;

    // 1. Check the Global Theme
    if (globals.currentTheme == 'animals') {
      emojiSet = ['🐶', '🐱', '🦁', '🐘', '🐯', '🦒', '🦓', '🐼'];
    } else if (globals.currentTheme == 'space') {
      emojiSet = ['🚀', '🪐', '👩‍🚀', '🛰️', '☄️', '🌌', '🔭', '👽'];
    } else {
      // Classic
      emojiSet = ['🍎', '🍕', '🚗', '🏀', '🎸', '🍦', '🍩', '🎁'];
    }

    // 2. Set Difficulty and Time
    int pairCount;
    if (widget.level == 'easy') {
      pairCount = 2; // 4 cards total
      timeLeft = 30;
    } else if (widget.level == 'medium') {
      pairCount = 4; // 8 cards total
      timeLeft = 60;
    } else {
      pairCount = 6; // 12 cards total
      timeLeft = 90;
    }

    // 3. Create the deck based on the theme
    List<String> selected = emojiSet.sublist(0, pairCount);
    cards = [...selected, ...selected];
    cards.shuffle();

    revealed = List.generate(cards.length, (index) => false);
    matched = List.generate(cards.length, (index) => false);
  }

  // ... (Keep your _startTimer, _showTimeUpDialog, oncardTap, checkcards, checkwin, _saveScoreToFirebase exactly as they were) ...

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft <= 0) {
        timer.cancel();
        setState(() => gameOver = true);
        _showTimeUpDialog();
      } else {
        setState(() => timeLeft--);
      }
    });
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('⏰ Time\'s Up!'),
        content: Text('Score: $score'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false),
            child: Text('Go Home'),
          ),
        ],
      ),
    );
  }

  void oncardTap(int index) {
    if (waiting || revealed[index] || matched[index] || gameOver) return;
    setState(() => revealed[index] = true);
    if (first_ind == null) {
      first_ind = index;
    } else if (sec_ind == null) {
      sec_ind = index;
      waiting = true;
      checkcards();
    }
  }

  void checkcards() async {
    await Future.delayed(Duration(seconds: 1));
    if (cards[first_ind!] == cards[sec_ind!]) {
      setState(() {
        matched[first_ind!] = true;
        matched[sec_ind!] = true;
        score += 10;
      });
    } else {
      setState(() {
        revealed[first_ind!] = false;
        revealed[sec_ind!] = false;
      });
    }
    first_ind = null;
    sec_ind = null;
    waiting = false;
    checkwin();
  }

  void checkwin() {
    if (!matched.contains(false)) {
      _timer?.cancel();
      _saveScoreToFirebase();
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('You Win! 🥳'),
          content: Text('Score: $score'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false),
              child: Text('Ok'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _saveScoreToFirebase() async {
    try {
      await FirebaseFirestore.instance.collection('scores').add({
        'name': widget.name,
        'level': widget.level,
        'score': score,
        'date': DateTime.now().toIso8601String(),
      });
    } catch (e) { print('Firebase error: $e'); }
  }

  Widget buildcard(int index) {
    return Text(
      revealed[index] ? cards[index] : '❓',
      style: TextStyle(fontSize: 30, color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.name} Level ${widget.level}'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/images/png5.jpeg"), fit: BoxFit.cover)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('⭐ Score: $score', style: TextStyle(color: Colors.white, fontSize: 18)),
                  Text('⏱ $timeLeft s', style: TextStyle(color: Colors.white, fontSize: 18)),
                ],
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: cards.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 10),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => oncardTap(index),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.deepPurple, borderRadius: BorderRadius.circular(12)),
                    child: Center(child: buildcard(index)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  @override
  void dispose() { _timer?.cancel(); super.dispose(); }
}