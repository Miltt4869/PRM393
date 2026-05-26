// Hàm viết bằng cú pháp arrow
int multiply(int a, int b) => a * b;

// Hàm viết bằng cú pháp thông thường
void greet(String name) {
  print("Xin chào $name!");
}

void main() {
  // 1. Khối lệnh if/else kiểm tra điểm
  int score = 85;
  if (score >= 90) {
    print("Grade: A");
  } else if (score >= 80) {
    print("Grade: B");
  } else {
    print("Grade: C");
  }

  // 2. Switch case cho ngày trong tuần
  String day = "Mon";
  switch (day) {
    case "Mon":
      print("Hôm nay là Thứ Hai");
      break;
    case "Tue":
      print("Hôm nay là Thứ Ba");
      break;
    default:
      print("Ngày khác");
  }

  // 3. Các loại vòng lặp
  List<String> fruits = ["Apple", "Banana", "Orange"];

  // Vòng lặp for truyền thống
  for (int i = 0; i < fruits.length; i++) {
    print("For loop: ${fruits[i]}");
  }

  // Vòng lặp for-in
  for (var fruit in fruits) {
    print("For-in loop: $fruit");
  }

  // Vòng lặp forEach
  fruits.forEach((fruit) => print("forEach loop: $fruit"));

  // 4. Gọi hàm
  greet("Học viên");
  print("3 * 4 = ${multiply(3, 4)}");
}