class Settings {
  // Khai báo một biến static chứa instance duy nhất (Singleton)
  static final Settings _instance = Settings._internal();

  // Private constructor (Không thể khởi tạo trực tiếp từ bên ngoài)
  Settings._internal() {
    print('Khoi tao Settings (Chỉ chạy 1 lần duy nhất!)');
  }

  // Factory constructor: Luôn trả về instance đã được cache
  factory Settings() {
    return _instance;
  }

  // Thêm một thuộc tính để test
  String theme = 'Dark';
}

void main() {
  print('Bắt đầu kiểm tra Factory Constructor...');

  // 1. Tạo instance đầu tiên
  Settings settingsA = Settings();
  settingsA.theme = 'Light';

  // 2. Tạo instance thứ hai
  Settings settingsB = Settings();

  // 3. In ra giá trị để kiểm tra xem thay đổi của A có phản ánh vào B không
  print('Theme của settingsA: ${settingsA.theme}');
  print('Theme của settingsB: ${settingsB.theme}');

  // 4. Xác minh hai instance là cùng một đối tượng trong bộ nhớ
  bool isSame = identical(settingsA, settingsB);
  print('settingsA và settingsB có identical không? -> $isSame');
  // Kết quả in ra sẽ là true.
}