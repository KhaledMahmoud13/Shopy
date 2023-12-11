import 'package:shopy/app/model/cart_item.dart';

class Order {
  final List<CartItem> items;
  final double orderPrice;
  final String status;

  Order({
    required this.items,
    required this.orderPrice,
    required this.status,
  });

  factory Order.fromDocument(Map<String, dynamic> data) => Order(
        items: List<CartItem>.from(
            data['items'].map((cartItem) => CartItem.fromDocument(cartItem))),
        orderPrice: data['orderPrice'],
        status: data['status'],
      );

  Map<String, dynamic> toDocument() => {
        'items': items.map((e) => e.toDocument()),
        'orderPrice': orderPrice,
        'status': status,
      };
}
