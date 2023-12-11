import 'package:shopy/app/model/cart_item.dart';
import 'package:shopy/app/model/order.dart';

class UserModel {
  String fullName;
  String email;
  String birthDate;
  double weight;
  double height;
  String gender;
  String? profilePicture;
  Set<int>? wishlist;
  List<CartItem>? cart;
  List<Order>? order;

  UserModel({
    required this.fullName,
    required this.email,
    required this.birthDate,
    required this.weight,
    required this.height,
    required this.gender,
    this.profilePicture,
    this.wishlist,
    this.cart,
    this.order,
  });

  void addToWishlist(int productId) {
    wishlist?.add(productId);
  }

  void removeFromWishlist(int productId) {
    wishlist?.removeWhere((element) => element == productId);
  }

  void addToCart(CartItem cartItem) {
    cart?.add(cartItem);
  }

  void removeFromCart(int cartItemIndex) {
    print('Before removal: ${cart?.length}');
    cart?.removeAt(cartItemIndex);
    print('After removal: ${cart?.length}');
  }

  void increaseQuantityOfCartItem(
    int cartItemIndex,
    Function(int productId, int newQuantity) editTotalPrice,
  ) {
    CartItem item = cart![cartItemIndex];
    if (item.quantity == 5) {
      return;
    }
    item.quantity++;
    editTotalPrice(item.productId, item.quantity);
  }

  void decreaseQuantityOfCartItem(
    int cartItemIndex,
    Function(int productId, int newQuantity) editTotalPrice,
  ) {
    CartItem item = cart![cartItemIndex];
    if (item.quantity == 1) {
      return;
    }
    item.quantity--;
    editTotalPrice(item.productId, item.quantity);
  }

  factory UserModel.fromDocument(Map<String, dynamic> data) => UserModel(
        fullName: data['fullName'],
        email: data['email'],
        birthDate: data['birthDate'],
        weight: data['weight'],
        height: data['height'],
        gender: data['gender'],
        profilePicture: data['profileImage'],
        wishlist:
            data['wishlist'] != null ? Set<int>.from(data['wishlist']) : {},
        cart: data['cart'] != null
            ? List<CartItem>.from(data['cart']
                .map((cartItemJson) => CartItem.fromDocument(cartItemJson)))
            : [],
        order: data['order'] != null
            ? List<Order>.from(
                data['order'].map((order) => Order.fromDocument(order)))
            : [],
      );

  Map<String, dynamic> toDocument() => {
        "fullName": fullName,
        "email": email,
        "birthDate": birthDate,
        "weight": weight,
        "height": height,
        "gender": gender,
        "profileImage": profilePicture,
        "wishlist": wishlist,
        "cart": cart,
        "order": order,
      };

  Map<String, dynamic> updateUser() => {
        "fullName": fullName,
        "birthDate": birthDate,
        "weight": weight,
        "height": height,
        "profileImage": profilePicture,
      };
}
