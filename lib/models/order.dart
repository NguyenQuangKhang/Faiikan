import 'package:faiikan/models/order_item.dart';

class Order {
  late String id;
  late int priceShip;
  late int totalPrice;
  late String address;
  late String methodPayment;
  late List<OrderItem> listOrderItem;
  late String deliveryStatus;
  late String shippingUnit;
  late String createDate;

  Order({
    required String Id,
    required int Priceship,
    required int TotalPrice,
    required String Address,
    required String MethodPayment,
    required List<OrderItem> list,
    required String DeliveryStatus,
    required String ShippingUnit,
    required String CreateDate,
  }) {
    id = Id;
    priceShip = Priceship;
    totalPrice = TotalPrice;
    address = Address;
    methodPayment = MethodPayment;
    listOrderItem = list;
    deliveryStatus = DeliveryStatus;
    shippingUnit = ShippingUnit;
    createDate = CreateDate;
  }
}
