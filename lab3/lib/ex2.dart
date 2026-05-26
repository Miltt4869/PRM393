import 'dart:convert';

// 1. Tạo User Model với constructor fromJson
class User {
  final String name;
  final String email;

  User({required this.name, required this.email});
  // // Constructor named để parse từ Map (dữ liệu JSON đã decode)
  User.fromJson(Map<String, dynamic> json): name = json['name'],
                                          email = json['email'];

  @override
  String toString() => 'User(name: $name, email: $email)';
}

//2. Mô phỏng JSON lấy từ API
const String jsonResponse = ''' 
[
  {"name": "Alice", "email": "alice@example.com"},
  {"name": "Bob", "email": "bob@example.com"}
]
''';

// 3. Hàm future để xử lý json trả về ds user
Future<List<User>> fetchUsers() async{
  // Mô phỏng delay mạng
  await Future.delayed(Duration(seconds: 1));
  //Giải mã chuỗi JSON thành List các Map
  List<dynamic> decodedJson = jsonDecode(jsonResponse);
  // // Ánh xạ (map) từng Map thành đối tượng User thông qua User.fromJson
  return decodedJson.map((json)=> User.fromJson(json)).toList();
}

void main() async{
  print('Đang lấy dữ liệu...');
  // 4. lấy dữ liệu và hiển thị kết quả
  List<User> users = await fetchUsers();
  for (var user in users) {
    print(user);
  }
}