import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/post_model.dart'; // Import Model

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  // --- YÊU CẦU 2: PHƯƠNG THỨC GET ---
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(baseUrl)).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body); // Parse JSON [cite: 349]
        return body.map((dynamic item) => Post.fromJson(item)).toList();
      } else {
        // YÊU CẦU 4: Xử lý lỗi từ server [cite: 509, 518]
        throw Exception('Lỗi máy chủ: ${response.statusCode}');
      }
    } catch (e) {
      // YÊU CẦU 4: Xử lý ngoại lệ (mất mạng, timeout)
      throw Exception('Lỗi kết nối. Vui lòng kiểm tra mạng!');
    }
  }

  // --- YÊU CẦU 2: PHƯƠNG THỨC POST ---
  Future<Post> createPost(String title, String body) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'title': title,
          'body': body,
          'userId': 1,
        }),
      );

      // Mã 201 là Created (Đã tạo thành công)
      if (response.statusCode == 201) {
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception('Không thể tạo bài viết: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Gửi dữ liệu thất bại. Vui lòng thử lại!');
    }
  }

  // --- PHƯƠNG THỨC PUT ---
  Future<Post> updatePost(int id, String title, String body) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode({
          'id': id,
          'title': title,
          'body': body,
          'userId': 1,
        }),
      );

      if (response.statusCode == 200) {
        return Post.fromJson(json.decode(response.body));
      } else {
        throw Exception('Không thể cập nhật bài viết: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Cập nhật thất bại. Vui lòng thử lại!');
    }
  }
}