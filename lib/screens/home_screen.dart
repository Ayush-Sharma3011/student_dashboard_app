import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:student_dashboard_app/screens/login_screen.dart';
import '../widgets/course_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List courses = [];
  bool isLoading = true;

  Future<void> fetchCourses() async {
  try {
    final response = await http.get(
      Uri.parse('https://api.jsonbin.io/v3/b/686a10e58561e97a50324f99'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print("API Data: $data");

      setState(() {
        courses = data['record']['courses'];
        isLoading = false;
      });
    } else {
      print("API error: ${response.statusCode}");
      setState(() {
        isLoading = false;
      });
    }
  } catch (e) {
    print("Exception while fetching: $e");
    setState(() {
      isLoading = false;
    });
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
          IconButton(
  icon: Icon(Icons.logout),
  onPressed: () {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false,
    );
  },
)

        ],
      ),
      body: isLoading
  ? Center(child: Lottie.asset('assets/loading.json', width: 200))
  : courses.isEmpty
      ? Center(child: Text("No courses found."))
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