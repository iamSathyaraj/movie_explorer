import 'package:flutter/material.dart';

class SavedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saved'),
        backgroundColor: const Color.fromARGB(255, 199, 53, 24),
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.bookmark_border, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text('Saved Movies', style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
