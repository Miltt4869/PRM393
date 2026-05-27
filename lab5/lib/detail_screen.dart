import 'package:flutter/material.dart';
import 'movie.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie; // Nhận object Movie

  const MovieDetailScreen({super.key, required this.movie});

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  // Trạng thái nút Favorite (Optional Enhancement)
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.movie.title),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. HERO BANNER (Ảnh + Gradient + Title) ---
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.network(
                  widget.movie.posterUrl,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                ),
                // Lớp Gradient phủ mờ từ dưới lên
                Container(
                  width: double.infinity,
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.8),
                      ],
                    ),
                  ),
                ),
                // Chữ Title đè lên ảnh
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.movie.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- 2. THỂ LOẠI (Genres Chips) ---
                  Wrap(
                    spacing: 8.0,
                    children: widget.movie.genres.map((genre) {
                      return Chip(
                        label: Text(genre, style: const TextStyle(color: Colors.black87)),
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: BorderSide(color: Colors.grey.shade300), // Viền xám mỏng như ảnh
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // --- 3. TÓM TẮT (Overview) ---
                  Text(
                    widget.movie.overview,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // --- 4. ACTION BUTTONS ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(
                        icon: isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : Colors.black87,
                        label: 'Favorite',
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                      _buildActionButton(
                        icon: Icons.star,
                        color: Colors.black87,
                        label: 'Rate',
                        onTap: () {},
                      ),
                      _buildActionButton(
                        icon: Icons.share,
                        color: Colors.black87,
                        label: 'Share',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // --- 5. TRAILERS ---
                  const Text(
                    'Trailers',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // ListView hiển thị trailer (Dùng shrinkWrap vì nằm trong SingleChildScrollView)
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.movie.trailers.length,
                    separatorBuilder: (context, index) => Divider(color: Colors.grey.shade300),
                    itemBuilder: (context, index) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero, // Ép sát lề trái
                        leading: const Icon(
                          Icons.play_circle_filled,
                          color: Color(0xFF4A4A4A),
                          size: 28,
                        ),
                        title: Text(
                          widget.movie.trailers[index],
                          style: const TextStyle(fontWeight: FontWeight.w500, color: Colors.black87),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Hàm tạo nút bấm Action (Icon + Text)
  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 14, color: Colors.black87)),
          ],
        ),
      ),
    );
  }
}