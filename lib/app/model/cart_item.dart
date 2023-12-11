class CartItem {
  final int productId;
  final String size;
  int quantity;
  double totalPrice;

  CartItem({
    required this.productId,
    required this.size,
    required this.quantity,
    required this.totalPrice,
  });

  factory CartItem.fromDocument(Map<String, dynamic> data) => CartItem(
        productId: data['productId'],
        size: data['size'],
        quantity: data['quantity'],
        totalPrice: data['totalPrice'],
      );

  Map<String, dynamic> toDocument() => {
        'productId': productId,
        'size': size,
        'quantity': quantity,
        'totalPrice': totalPrice,
      };
}
