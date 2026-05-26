import 'package:flutter/material.dart';

class CoreWidgetsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercise 1 - Core Widgets')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 1. Headline Text
            Text(
              'Welcome to Flutter UI',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // 2. Icon bằng Material Icons
            Icon(Icons.movie, size: 80, color: Colors.blue),
            SizedBox(height: 20),

            // 3. Image.network() (Sử dụng một ảnh hợp lệ bất kỳ)
            Image.network(
              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg',
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),

            // 4. Card chứa ListTile
            Card(
              elevation: 4,
              child: ListTile(
                leading: Icon(Icons.star, color: Colors.amber),
                title: Text('Movie Item'),
                subtitle: Text('This is a sample ListTile inside a Card.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}