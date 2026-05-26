import 'package:flutter/material.dart';

class CommonUIFixesDemo extends StatefulWidget {
  const CommonUIFixesDemo({super.key});

  @override
  State<CommonUIFixesDemo> createState() => _CommonUIFixesDemoState();
}

class _CommonUIFixesDemoState extends State<CommonUIFixesDemo> {
  String _selectedDate = "Chưa chọn";

  // SỬA LỖI 4: Gọi DatePicker từ BuildContext hợp lệ (context của State)
  void _pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      // SỬA LỖI 3: Dùng setState() để cập nhật lại giao diện sau khi có dữ liệu mới
      setState(() {
        _selectedDate = "${date.day}/${date.month}/${date.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 5 – Common UI Fixes'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==========================================
          // PHẦN 1: GIAO DIỆN
          // ==========================================
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 16.0),
            child: Text(
              'Correct ListView inside Column using Expanded',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87
              ),
            ),
          ),

          // SỬA LỖI 1: Bọc ListView.builder bằng Expanded để tránh lỗi Unbounded Height
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  leading: Icon(Icons.movie, color: Color(0xFF4A4F5C)),
                  title: Text('Movie A', style: TextStyle(fontSize: 16)),
                ),
                ListTile(
                  leading: Icon(Icons.movie, color: Color(0xFF4A4F5C)),
                  title: Text('Movie B', style: TextStyle(fontSize: 16)),
                ),
                ListTile(
                  leading: Icon(Icons.movie, color: Color(0xFF4A4F5C)),
                  title: Text('Movie C', style: TextStyle(fontSize: 16)),
                ),
                ListTile(
                  leading: Icon(Icons.movie, color: Color(0xFF4A4F5C)),
                  title: Text('Movie D', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),

          const Divider(thickness: 1, height: 1),

          // ==========================================
          // PHẦN 2: THÊM CÁC CHỨC NĂNG
          // ==========================================
          /*const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Các phần sửa lỗi khác:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),

          // SỬA LỖI 2: Dùng SingleChildScrollView để tránh lỗi Overflow (tràn viền vàng đen)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: List.generate(
                10, // Tạo ra 10 hộp thoại dài, nếu không có SingleChildScrollView sẽ bị lỗi
                    (index) => Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text('Item $index'),
                ),
              ),
            ),
          ),

          // Hiển thị nút bấm để test lỗi 3 và 4
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Ngày đã chọn: $_selectedDate'),
                ElevatedButton(
                  onPressed: _pickDate,
                  child: const Text('Mở Date Picker'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24), // Khoảng trống dưới cùng

           */
        ],
      ),
    );
  }
}