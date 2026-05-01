import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  double _rating = 5.0; // Default rating

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Lighter background color for a clean look
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("User Feedback", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "How was your experience?",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const SizedBox(height: 10),
            const Text(
              "We'd love to hear your thoughts on Flipsters!",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            // Feedback Text Field
            const Text("Your Comments", style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            TextField(
              controller: _feedbackController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Type your feedback here...",
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Rating Slider (Optional but looks great)
            Text("Rate your fun: ${_rating.toInt()}/10",
                style: const TextStyle(fontWeight: FontWeight.w600)),
            Slider(
              value: _rating,
              min: 1,
              max: 10,
              divisions: 9,
              activeColor: Colors.deepPurple,
              label: _rating.round().toString(),
              onChanged: (double value) {
                setState(() {
                  _rating = value;
                });
              },
            ),

            const SizedBox(height: 40),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () {
                  // Logic to save feedback (e.g., to Firebase) would go here
                  print("Feedback: ${_feedbackController.text}");
                  print("Rating: $_rating");

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Thank you for your feedback!")),
                  );
                  Navigator.pop(context);
                },
                child: const Text(
                  "SUBMIT FEEDBACK",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}