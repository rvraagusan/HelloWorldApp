import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text("Profile card"),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
        ),
        body: const Center(
          child: ProfileCard(),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 8,
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/profile.png")
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              "Ragushan Ravi",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              "Flutter Developer",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.email, color: Colors.blueAccent),
                  SizedBox(width: 8),
                  Text("ragushan@example.com"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const[
                  Icon(Icons.phone, color: Colors.green),
                  SizedBox(width: 8),
                  Text("+94 71 234 5678"),
                ],
              )
          ],
        ),
      ),
    );
  }
}
