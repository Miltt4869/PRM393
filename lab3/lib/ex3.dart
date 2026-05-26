import 'dart:async';

void main() {
  print('1. Bắt đầu hàm main (Đồng bộ - Sync)');

  // Future mặc định được đưa vào Event Queue
  Future(() {
    print('4. Thực thi Future (Event Queue)');
  });

  // Microtask được đưa vào Microtask Queue
  scheduleMicrotask(() {
    print('3. Thực thi Microtask (Microtask Queue)');
  });

  print('2. Kết thúc hàm main (Đồng bộ - Sync)');

  /*
   * GIẢI THÍCH (Explanation):
   * Event Loop trong Dart ưu tiên xử lý hoàn toàn "Microtask Queue"
   * trước khi chuyển sang xử lý các tác vụ trong "Event Queue" (như Future).
   * Do đó:
   * - Các lệnh đồng bộ (Sync) chạy ngay lập tức (1, 2).
   * - Sau khi hàm main kết thúc, Event Loop kiểm tra Microtask Queue và chạy trước (3).
   * - Khi Microtask Queue đã trống, nó mới chuyển sang Event Queue và chạy Future (4).
   */
}