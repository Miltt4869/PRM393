import 'package:flutter/material.dart';

class InputControlsDemo extends StatefulWidget {
  const InputControlsDemo({super.key});

  @override
  State<InputControlsDemo> createState() => _InputControlsDemoState();
}

class _InputControlsDemoState extends State<InputControlsDemo> {
  // 1. Khai báo các biến lưu trữ trạng thái (State)
  double _rating = 50;
  bool _isActive = false;
  String? _selectedGenre;
  DateTime? _selectedDate;

  // 2. Hàm xử lý khi người dùng nhấn nút mở Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 2 – Input Controls'),
      ),
      // Sử dụng ListView để màn hình có thể cuộn được nếu nội dung quá dài
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [

          // --- PHẦN 1: SLIDER ---
          const Text(
            'Rating (Slider)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Slider(
            value: _rating,
            min: 0,
            max: 100,
            onChanged: (value) {
              setState(() {
                _rating = value;
              });
            },
          ),
          Text(
            'Current value: ${_rating.round()}',
            style: const TextStyle(color: Colors.black87),
          ),
          const SizedBox(height: 24), // Khoảng cách giữa các phần

          // --- PHẦN 2: SWITCH ---
          const Text(
            'Active (Switch)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Text('Is movie active?', style: TextStyle(fontSize: 15)),
              ),
              Switch(
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 24),

          // --- PHẦN 3: RADIOLISTTILE ---
          const Text(
            'Genre (RadioListTile)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          RadioListTile<String>(
            title: const Text('Action'),
            value: 'Action',
            groupValue: _selectedGenre,
            contentPadding: EdgeInsets.zero, // Căn lề sát viền trái
            onChanged: (value) {
              setState(() {
                _selectedGenre = value;
              });
            },
          ),
          RadioListTile<String>(
            title: const Text('Comedy'),
            value: 'Comedy',
            groupValue: _selectedGenre,
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              setState(() {
                _selectedGenre = value;
              });
            },
          ),
          Text(
            'Selected genre: ${_selectedGenre ?? "None"}',
            style: const TextStyle(color: Colors.black87),
          ),
          const SizedBox(height: 24),

          // --- PHẦN 4: DATE PICKER BUTTON ---
          SizedBox(
            width: double.infinity, // Nút bấm trải dài hết màn hình
            height: 45,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFF3F4F9), // Màu nền xám/tím nhạt
                side: const BorderSide(color: Color(0xFFE2E4EC)), // Màu viền
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Bo góc
                ),
              ),
              onPressed: () => _selectDate(context),
              child: const Text(
                'Open Date Picker',
                style: TextStyle(
                  color: Color(0xFF5F659C), // Màu chữ tím
                  fontSize: 15,
                ),
              ),
            ),
          ),

          // Hiển thị ngày đã chọn (nếu có) ngay dưới nút
          if (_selectedDate != null) ...[
            const SizedBox(height: 12),
            Text(
              'Selected Date: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
              textAlign: TextAlign.center,
            ),
          ]
        ],
      ),
    );
  }
}