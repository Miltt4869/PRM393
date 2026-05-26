import 'dart:async';
// 1.Product Model
class Product{
  final int id;
  final String name;
  final double price;

  Product(this.id, this.name, this.price);

  @override
  String toString() => 'Product(id: $id, name: $name, price: $price)';
}

// 2. Cài đặt ProductRepository
class ProductRepository{
  final List<Product> _products = [
    Product(1, 'Laptop', 1500.0),
    Product(2, 'Phone', 800.0),
  ];
  
//  Sử dụng StreamController.broadcast tạo luồng dữ liệu(Stream)
final StreamController<Product> _controller = StreamController<Product>.broadcast();
//Future mô phỏng việc lấy toàn bộ dữ liệu từ database( bất đồng bộ)
Future<List<Product>> getAll() async{
  await Future.delayed(Duration(seconds: 1)); // mô phỏng delay mạng
  return _products;
  }
  // Stream để lắng nghe các sản phẩm mới đc thêm vào
  Stream<Product> liveAdded() => _controller.stream;
  //Thêm sản phẩm và phát dữ liệu qua stream
  void addProduct(Product product){
    _products.add(product);
    _controller.add(product);// phát sự kiện có sp mới
  }
  // Đóng controller khi ko dùng tránh rò rỉ dữ liệu
  void dispose(){
    _controller.close();
  }
}

void main() async{
  final repo = ProductRepository();
  // lắng nghe stream trước khi bắt đầu các sự kiện thêm sp
  repo.liveAdded()
      .listen((newProduct){ print('🚨 [Stream Event] Sản phẩm mới được thêm: $newProduct');
      });
  print('Đang tảit sản phẩm...');
  // gọi Future để lấy danh sách
  List<Product> allProduct = await repo.getAll();
  print('Danh sách hiện tại: $allProduct');
  
  // Thêm sản phẩm mới để kích hoạt Stream
  repo.addProduct(Product(3, 'Tablet', 600.0));
  repo.addProduct(Product(4, 'Smartwatch', 250.0));
}
