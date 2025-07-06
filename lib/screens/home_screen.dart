import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lottie/lottie.dart';
import '../widgets/course_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List courses = [];
  bool isLoading = true;

  Future<void> fetchCourses() async {
    final response = await http.get(Uri.parse('https://myapi.example.com/api/courses'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        courses = data['courses'];
        isLoading = false;
      });
    } else {
      throw Exception('Failed to load courses');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome, Student!", style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(icon: Icon(Icons.logout), onPressed: () => Navigator.pop(context)),
        ],
      ),
      body: isLoading
          ? Center(child: Lottie.asset('assets/loading.json', width: 200))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: courses.map((course) {
                  return CourseCard(
                    title: course['title'] ?? 'Untitled',
                    progress: (course['progress'] ?? 0.0).toDouble(),
                    nextClass: course['nextClass'] ?? 'TBA',
                  );
                }).toList(),
              ),
            ),
    );
  }
}