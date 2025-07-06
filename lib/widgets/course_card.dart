import 'package:flutter/material.dart';
import 'progress_bar.dart';
import 'package:animate_do/animate_do.dart';

class CourseCard extends StatelessWidget {
  final String title;
  final double progress;
  final String nextClass;

  const CourseCard({super.key, required this.title, required this.progress, required this.nextClass});

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      duration: Duration(milliseconds: 500),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              ProgressBar(value: progress),
              SizedBox(height: 8),
              Text("Next Class: $nextClass", style: TextStyle(color: Colors.grey[700])),
            ],
          ),
        ),
      ),
    );
  }
}