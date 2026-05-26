import 'package:flutter/material.dart';
// Import file ex1.dart
import 'ex1.dart';
import 'ex2.dart';
import 'ex3.dart';
import 'ex4.dart';
import 'ex5.dart';

void main() {
  runApp(const MyApp());
}

// Widget gốc của toàn bộ ứng dụng
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 4 - Flutter UI',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF8F9FA), // Màu nền xám nhạt giống ảnh 1
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F9FA),
          elevation: 0,
          foregroundColor: Colors.black, // Chữ màu đen
        ),
      ),
      home: const Lab4HomeScreen(), // Màn hình chính là Menu
    );
  }
}

// Giao diện Màn hình Menu
class Lab4HomeScreen extends StatelessWidget {
  const Lab4HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lab 4 – Flutter UI Fundament...',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Nút chuyển sang Exercise 1
          _buildMenuButton(
            context,
            title: 'Exercise 1 – Core Widgets Demo',
            // Truyền class từ file ex1.dart vào đây
            destinationPage: CoreWidgetsDemo(),
          ),

          // truyền ex2
          _buildMenuButton(
            context,
            title: 'Exercise 2 – Input Controls Demo',
            destinationPage: InputControlsDemo(),
          ),

          _buildMenuButton(
            context,
            title: 'Exercise 3 – Layout Demo',
            destinationPage: LayoutDemo(),
          ),

          _buildMenuButton(
            context,
            title: 'Exercise 4 – App Structure & Theme',
            destinationPage: AppStructureDemo(),
          ),

          _buildMenuButton(
            context,
            title: 'Exercise 5 – Common UI Fixes',
            destinationPage: CommonUIFixesDemo(),
          ),
        ],
      ),
    );
  }

  // Hàm tạo ra giao diện 1 cục nút bấm (Container màu xám bo góc có mũi tên)
  Widget _buildMenuButton(BuildContext context, {required String title, required Widget destinationPage}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12), // Bo góc hiệu ứng nhấn
        onTap: () {
          // Lệnh chuyển trang trong Flutter
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destinationPage),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          decoration: BoxDecoration(
            color: const Color(0xFFF1F3F5), // Màu xám của các cục item
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black87),
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}