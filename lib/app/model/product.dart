class Product {
  final int id;
  final String name;
  final int price;
  final String gender;
  final String imageUrl;
  final String? weight;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.gender,
    required this.imageUrl,
    this.weight
  });

  factory Product.fromValue(Map<dynamic, dynamic> value) =>
      Product(
        id: value["id"],
        name: value["name"],
        price: value["price"],
        gender: value["gender"],
        imageUrl: value["imageUrl"],
        weight: value["weight"],
      );
}
