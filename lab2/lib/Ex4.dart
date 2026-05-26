// 1. Tạo class Car
class Car {
  String brand;

  // Constructor mặc định
  Car(this.brand);

  // 2. Named constructor
  Car.unknown() : brand = "Unknown Brand";

  // Phương thức của class
  void drive() {
    print("Lái chiếc xe hiệu $brand.");
  }
}

// 3. Class con kế thừa và ghi đè
class ElectricCar extends Car {
  int batteryCapacity;

  ElectricCar(String brand, this.batteryCapacity) : super(brand);

  @override
  void drive() {
    print("Lái xe điện $brand với dung lượng pin là $batteryCapacity kWh.");
  }
}

void main() {
  // 4. Khởi tạo đối tượng và in kết quả
  Car myCar = Car("Toyota");
  myCar.drive();

  Car mysteriousCar = Car.unknown();
  mysteriousCar.drive();

  ElectricCar myTesla = ElectricCar("Tesla", 100);
  myTesla.drive();
}