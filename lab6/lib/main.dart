import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ==========================================
// BƯỚC 1 & 3: KHỞI TẠO APP & MATERIAL APP
// ==========================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 6 - Responsive Movie UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
      ),
      home: const GenreScreen(),
    );
  }
}

// ==========================================
// BƯỚC 2: DATA MODEL & DỮ LIỆU MẪU
// ==========================================
class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

// Dữ liệu mẫu (Static sample data)
final List<Movie> allMovies = [
  Movie(
    title: 'Dune: Part Two',
    year: 2024,
    genres: ['Action', 'Sci-Fi', 'Adventure'],
    posterUrl: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?w=400&q=80',
    rating: 8.8,
  ),
  Movie(
    title: 'Oppenheimer',
    year: 2023,
    genres: ['Drama', 'Biography', 'History'],
    posterUrl: 'https://images.unsplash.com/photo-1447433589675-4aaa569f3e05?w=400&q=80',
    rating: 8.4,
  ),
  Movie(
    title: 'Spider-Man: Across the Spider-Verse',
    year: 2023,
    genres: ['Animation', 'Action', 'Adventure'],
    posterUrl: 'https://images.unsplash.com/photo-1608889175123-8ee362201f81?w=400&q=80',
    rating: 8.7,
  ),
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    genres: ['Action', 'Crime', 'Drama'],
    posterUrl: 'https://images.unsplash.com/photo-1509347528160-9a9e33742cdb?w=400&q=80',
    rating: 9.0,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Sci-Fi', 'Drama', 'Adventure'],
    posterUrl: 'https://m.media-amazon.com/images/M/MV5BYzdjMDAxZGItMjI2My00ODA1LTlkNzItOWFjMDU5ZDJlYWY3XkEyXkFqcGc@._V1_.jpg',
    rating: 8.6,
  ),
  Movie(
    title: 'Knives Out',
    year: 2019,
    genres: ['Comedy', 'Crime', 'Drama'],
    posterUrl: 'https://images.unsplash.com/photo-1584905066893-7d5c142ba4e1?w=400&q=80',
    rating: 7.9,
  ),
];

// Các thể loại có sẵn để hiển thị trên Filter Chips
final List<String> availableGenres = [
  'Action', 'Sci-Fi', 'Adventure', 'Drama', 'Biography',
  'History', 'Animation', 'Crime', 'Comedy'
];

// ==========================================
// MÀN HÌNH CHÍNH (GIAO DIỆN & LOGIC)
// ==========================================
class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  // Trạng thái (State variables)
  String searchQuery = '';
  Set<String> selectedGenres = {};
  String selectedSort = 'A-Z'; // Tùy chọn mặc định
  final List<String> sortOptions = ['A-Z', 'Z-A', 'Year', 'Rating'];

  // [BONUS]: Hàm xóa toàn bộ bộ lọc
  void clearFilters() {
    setState(() {
      searchQuery = '';
      selectedGenres.clear();
      selectedSort = 'A-Z';
    });
  }

  // ==========================================
  // BƯỚC 7: LOGIC LỌC VÀ SẮP XẾP PHIM
  // ==========================================
  List<Movie> get visibleMovies {
    List<Movie> filtered = allMovies.where((movie) {
      // 1. Lọc theo tên (Search)
      final matchSearch = movie.title.toLowerCase().contains(searchQuery.toLowerCase());

      // 2. Lọc theo thể loại (Genre)
      final matchGenre = selectedGenres.isEmpty ||
          movie.genres.any((genre) => selectedGenres.contains(genre));

      return matchSearch && matchGenre;
    }).toList();

    // 3. Sắp xếp (Sort)
    filtered.sort((a, b) {
      switch (selectedSort) {
        case 'A-Z':
          return a.title.compareTo(b.title);
        case 'Z-A':
          return b.title.compareTo(a.title);
        case 'Year':
          return b.year.compareTo(a.year); // Năm mới nhất lên trước
        case 'Rating':
          return b.rating.compareTo(a.rating); // Điểm cao nhất lên trước
        default:
          return 0;
      }
    });

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Sử dụng SafeArea để tránh notch/tai thỏ
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- TIÊU ĐỀ & NÚT CLEAR FILTER ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Text(
                        'Find a Movie',
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      // [BONUS]: Badge hiển thị số lượng thể loại đang chọn
                      if (selectedGenres.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${selectedGenres.length}',
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                    ],
                  ),
                  // [BONUS]: Nút Clear Filters
                  if (searchQuery.isNotEmpty || selectedGenres.isNotEmpty || selectedSort != 'A-Z')
                    TextButton.icon(
                      onPressed: clearFilters,
                      icon: const Icon(Icons.clear_all),
                      label: const Text('Clear'),
                    )
                ],
              ),
              const SizedBox(height: 16),

              // --- BƯỚC 4: THANH TÌM KIẾM (Search Bar) ---
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search by title...',
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // --- BƯỚC 5: THỂ LOẠI (Genre Chips) ---
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: availableGenres.map((genre) {
                  final isSelected = selectedGenres.contains(genre);
                  return FilterChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          selectedGenres.add(genre);
                        } else {
                          selectedGenres.remove(genre);
                        }
                      });
                    },
                    selectedColor: Colors.indigo.shade100,
                    checkmarkColor: Colors.indigo,
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // --- BƯỚC 6: DROPDOWN SẮP XẾP (Sort Options) ---
              Row(
                children: [
                  const Text('Sort by: ', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  DropdownButton<String>(
                    value: selectedSort,
                    items: sortOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedSort = newValue;
                        });
                      }
                    },
                  ),
                ],
              ),
              const Divider(height: 32),

              // --- BƯỚC 8: DANH SÁCH PHIM ĐÁP ỨNG (Responsive Movie List) ---
              Expanded(
                child: visibleMovies.isEmpty
                    ? const Center(child: Text('No movies found matching your criteria.'))
                    : LayoutBuilder(
                  builder: (context, constraints) {
                    // Nếu chiều rộng màn hình lớn hơn hoặc bằng 800px -> Dùng GridView (2 cột)
                    if (constraints.maxWidth >= 800) {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 600, // Chiều rộng tối đa của 1 cột
                          mainAxisExtent: 160,     // Chiều cao cố định khớp với thẻ Card ở trên
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) {
                          return _buildMovieCard(visibleMovies[index]);
                        },
                      );
                    }
                    // Nếu chiều rộng nhỏ hơn 800px -> Dùng ListView (1 cột)
                    else {
                      return ListView.builder(
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: _buildMovieCard(visibleMovies[index]),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget phụ trợ để vẽ thẻ phim (Movie Card)
  Widget _buildMovieCard(Movie movie) {
    return SizedBox(
      height: 160,
      child: Card(
        elevation: 1, // Giảm bóng đổ một chút cho giống ảnh mẫu
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        // Quan trọng: Tự động cắt phần ảnh vuông bị dư ra khỏi viền bo cong của Card
        clipBehavior: Clip.antiAlias, 
        child: Row(
          // Quan trọng: Ép cả ảnh và phần text phải kéo giãn cao bằng nhau
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Phần 1: Ảnh Poster ---
            SizedBox(
              width: 130, // Chiều rộng ảnh (bạn có thể tăng giảm tùy ý)
              child: Image.network(
                movie.posterUrl,
                // Thuộc tính thần thánh giúp ảnh luôn lấp đầy khung mà không bị méo
                fit: BoxFit.cover, 
              ),
            ),
            
            // --- Phần 2: Thông tin phim ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center, // Căn giữa chữ theo chiều dọc
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Year: ${movie.year}', 
                      style: TextStyle(color: Colors.grey.shade700, fontSize: 14)
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(
                          '${movie.rating}', 
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
                        ),
                      ],
                    ),
                    const Spacer(), // Đẩy phần thể loại xuống đáy
                    Text(
                      movie.genres.join(', '),
                      style: const TextStyle(fontSize: 13, color: Colors.indigo),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}