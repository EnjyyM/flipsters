import 'package:flutter/material.dart';
import 'globals.dart' as globals; // Connecting to the shared storage

class PersonalizationScreen extends StatefulWidget {
  const PersonalizationScreen({super.key});

  @override
  State<PersonalizationScreen> createState() => _PersonalizationScreenState();
}

class _PersonalizationScreenState extends State<PersonalizationScreen> {
  // Local choice that updates the UI while clicking
  String tempSelection = globals.currentTheme;

  final List<Map<String, dynamic>> themes = [
    {'id': 'classic', 'name': 'Classic', 'icons': '🍎🍕🚗', 'color': Colors.pinkAccent},
    {'id': 'animals', 'name': 'Animals', 'icons': '🐶🐱🦁', 'color': Colors.orange},
    {'id': 'space', 'name': 'Space', 'icons': '🚀🪐👩‍🚀', 'color': Colors.deepPurple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Theme")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: themes.length,
              itemBuilder: (context, index) {
                final theme = themes[index];
                bool isSelected = tempSelection == theme['id'];

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      tempSelection = theme['id'];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: isSelected ? theme['color'].withOpacity(0.1) : Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: isSelected ? theme['color'] : Colors.grey.shade300,
                        width: isSelected ? 3 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("${theme['icons']} ${theme['name']}", style: const TextStyle(fontSize: 18)),
                        if (isSelected) Icon(Icons.check_circle, color: theme['color']),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // THE KEY STEP: Save to the bulletin board
                  globals.currentTheme = tempSelection;
                  Navigator.pop(context);
                },
                child: const Text("Save Selection"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}