import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: const Color.fromARGB(255, 179, 47, 26),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(radius: 50, backgroundColor: Colors.blue),
            SizedBox(height: 20),
            Text('mathew', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text('Movie Lover', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}
