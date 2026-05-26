import 'package:flutter/material.dart';

class AppStructureDemo extends StatefulWidget {
  const AppStructureDemo({super.key});

  @override
  State<AppStructureDemo> createState() => _AppStructureDemoState();
}

class _AppStructureDemoState extends State<AppStructureDemo> {
  // Biến lưu trữ trạng thái Theme (Mặc định là Light Mode)
  ThemeMode _themeMode = ThemeMode.light;

  @override
  Widget build(BuildContext context) {
    // Trả về một MaterialApp cục bộ để có thể sử dụng thuộc tính 'themeMode'
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Tắt chữ DEBUG ở góc phải
      // 1. Tùy chỉnh ThemeData cho chế độ Sáng
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF8F9FA),
          foregroundColor: Colors.black, // Chữ và icon màu đen
          elevation: 0,
        ),
      ),
      // 2. Tùy chỉnh ThemeData cho chế độ Tối
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1E1E1E),
          foregroundColor: Colors.white, // Chữ và icon màu trắng
          elevation: 0,
        ),
      ),
      // 3. Liên kết themeMode với biến trạng thái
      themeMode: _themeMode,

      // 4. Tạo cấu trúc màn hình với Scaffold
      home: Scaffold(
        appBar: AppBar(
          // Nút Back thủ công để thoát khỏi MaterialApp này và về lại Menu chính
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context, rootNavigator: true).pop(),
          ),
          title: const Text(
            'Exercise 4 – App Str...',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            Row(
              children: [
                const Text('Dark', style: TextStyle(fontSize: 16)),
                const SizedBox(width: 4),
                Switch(
                  value: _themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    // Cập nhật trạng thái khi gạt Switch
                    setState(() {
                      _themeMode = value ? ThemeMode.dark : ThemeMode.light;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(width: 12),
          ],
        ),
        // 5. Phần Body
        body: const Center(
          child: Text(
            'This is a simple screen with theme toggle.',
            style: TextStyle(fontSize: 16),
          ),
        ),
        // 6. Nút FloatingActionButton (Yêu cầu của bài dù không thấy trong ảnh chụp)
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Hiển thị một thông báo nhỏ (SnackBar) khi bấm
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('FAB Clicked!')),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}