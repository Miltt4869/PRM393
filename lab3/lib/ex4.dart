import 'dart:async';

// Hàm tạo Stream các số từ 1 đến 5
Stream<int> generateNumbers() async*{
  for(int i=1; i<=5 ; i++){
    await Future.delayed(Duration(milliseconds: 500));// Delay nhỏ để thấy rõ stream
    yield i;
  }
}
void main(){
  print('Bắt đầu Stream Transformation...');

  // 1. Lấy stream cơ bản
  Stream<int> numberStream = generateNumbers();

  //2. Chuyển đổi qua map() và where()
  numberStream
  // Ánh xạ các giá trị thành bình phương của chúng
  .map((number)=> number * number)
  // Lọc và chỉ giữ lại các kết quả là số chẵn
  .where((squaredNumber) => squaredNumber % 2 == 0)
  // Lắng nghe stream đã được transform và in ra kết quả
  .listen(
      (result) => print('Giá trị nhận được: $result'),
    onDone: ()=> print('Đã hoàn thành Stream!'),
  );
}