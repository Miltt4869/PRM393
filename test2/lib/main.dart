import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Nạp giao diện HomeScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 8 & Test 2 App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(), // Đặt HomeScreen làm màn hình đầu tiên
      debugShowCheckedModeBanner: false,
    );
  }
}