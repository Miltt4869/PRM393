// 1 & 2. Hàm async với Future và Future.delayed
Future<void> fetchUserData() async {
  print("Đang tải dữ liệu...");
  await Future.delayed(Duration(seconds: 2));
  print("Tải dữ liệu hoàn tất!");
}

// 4. Tạo Stream phát ra các số nguyên
Stream<int> countNumbers() async* {
  for (int i = 1; i <= 3; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

void main() async {
  // 3. Thực hành Null-safety
  String? nullableString; // Biến có thể null (?)

  // Dùng toán tử (??) để cung cấp giá trị mặc định nếu null
  print("Giá trị là: ${nullableString ?? 'Giá trị mặc định'}");

  nullableString = "Bây giờ đã có dữ liệu";
  // Dùng toán tử (!) khi chắc chắn biến không null
  print("Độ dài chuỗi: ${nullableString!.length}");

  // Gọi hàm async
  await fetchUserData();

  // Lắng nghe dữ liệu từ Stream
  print("Bắt đầu đếm stream:");
  await for (int number in countNumbers()) {
    print("Stream nhận được: $number");
  }
}