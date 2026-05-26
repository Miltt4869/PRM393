void main() {
  // 1. List các số nguyên và các hàm cơ bản
  List<int> numbers = [10, 20, 30];
  print("List hiện tại: $numbers");
  numbers.add(40); // Thêm phần tử
  numbers.remove(10); // Xóa phần tử
  print("List sau khi thêm-xóa: $numbers, phần tử đầu tiên: ${numbers[0]}");

  // 2. Các toán tử số học, so sánh và logic
  int a = 15;
  int b = 5;
  print("a + b = ${a + b}");
  print("a == b? ${a == b}");
  print("a > 10 && b < 10? ${a > 10 && b < 10}");

  // Toán tử ba ngôi (? :)
  String result = (a > b) ? "a lớn hơn b" : "a nhỏ hơn hoặc bằng b";
  print("Kết quả so sánh: $result");

  // 3. Set (giữ các giá trị duy nhất)
  Set<String> uniqueNames = {'Alice', 'Bob', 'Alice'};
  print("Set (loại bỏ trùng lặp): $uniqueNames");

  // 4. Map (Key-Value)
  Map<String, int> scores = {'Math': 90, 'Science': 85};
  scores['English'] = 88; // Thêm vào map
  print("Điểm môn Math: ${scores['Math']}");
}