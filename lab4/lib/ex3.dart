import 'package:flutter/material.dart';

class LayoutDemo extends StatelessWidget {
  const LayoutDemo({super.key});

  @override
  Widget build(BuildContext context) {
    // Danh sách phim mẫu
    final List<String> movies = ['Avatar', 'Inception', 'Interstellar', 'Joker'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise 3 – Layout Demo'),
      ),
      // Sử dụng Column để bố cục các phần theo chiều dọc
      body: Column(
        children: [
          // --- PHẦN 1: TIÊU ĐỀ NOW PLAYING ---
          Padding(
            padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
            // YÊU CẦU: Sử dụng Row (mình thêm một icon nhỏ cạnh chữ để có lý do dùng Row)
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(Icons.play_circle_outline, color: Colors.black87, size: 28),
                // YÊU CẦU: Thêm khoảng trống bằng SizedBox (8px)
                SizedBox(width: 8),
                Text(
                  'Now Playing',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // YÊU CẦU: Thêm khoảng trống bằng SizedBox (16px)
          const SizedBox(height: 16),

          // --- PHẦN 2: DANH SÁCH PHIM ---
          // Bọc ListView trong Expanded để nó chiếm toàn bộ không gian còn lại của Column
          Expanded(
            // YÊU CẦU: Sử dụng ListView.builder
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0), // YÊU CẦU: Spacing nhất quán 16px
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movieTitle = movies[index];

                return Card(
                  elevation: 0,
                  color: const Color(0xFFF8F9FA),
                  margin: const EdgeInsets.only(bottom: 12.0), // YÊU CẦU: Spacing nhất quán 12px
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFE8EAF6),
                      child: Text(
                        movieTitle[0],
                        style: const TextStyle(
                          color: Color(0xFF3F51B5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    title: Text(
                      movieTitle,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: const Text(
                      'Sample description',
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 14,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}