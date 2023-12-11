import 'package:flutter/material.dart';
import 'package:shopy/app/model/cart_item.dart';
import 'package:shopy/app/model/order.dart';
import 'package:shopy/app/model/product.dart';
import 'package:shopy/app/model/user_model.dart';
import 'package:shopy/app/repository/user_repository.dart';
import 'package:shopy/app/viewmodel/authentication_view_model.dart';
import 'package:shopy/app/viewmodel/shop_view_model.dart';
import 'package:shopy/core/util/enums.dart';
import 'package:shopy/core/util/extensions.dart';

class UserViewModel with ChangeNotifier {
  final UserRepository userRepository;
  final AuthenticationViewModel authenticationViewModel;
  final ShopViewModel shopViewModel;

  UserViewModel({
    required this.userRepository,
    required this.authenticationViewModel,
    required this.shopViewModel,
  });

  RequestStatus requestStatus = RequestStatus.initial;
  String imagePath = "";

  void setImagePath(String path) {
    imagePath = path;
    notifyListeners();
  }

  Future<UserModel?> _getCurrentUser(String userId) async {
    try {
      UserModel? user = await userRepository.getUser(userId);

      if (user != null) {
        return user;
      } else {
        return null;
      }
    } catch (e) {
      print('Error during getting user: $e');
      return null;
    }
  }

  Future<void> updateUser({
    required String userId,
    required String fullName,
    required String birthDate,
    required double weight,
    required double height,
  }) async {
    requestStatus = RequestStatus.loading;
    notifyListeners();
    try {
      UserModel? user = await _getCurrentUser(userId);
      user?.fullName = fullName;
      user?.birthDate = birthDate;
      user?.weight = weight;
      user?.height = height;
      String? imageUrl =
          await userRepository.updateUser(userId, user!, imagePath);
      authenticationViewModel.updateCurrentUser(
        fullName: fullName,
        birthDate: birthDate,
        weight: weight,
        height: height,
        imageUrl: imageUrl ?? user.profilePicture,
      );
      _resetValues();
      requestStatus = RequestStatus.loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      requestStatus = RequestStatus.error;
      notifyListeners();
    }
  }

  Future<void> updateWishlist({
    required String userId,
    required int itemId,
  }) async {
    if (itemId
        .isProductInWishlist(authenticationViewModel.currentUser.wishlist!)) {
      authenticationViewModel.currentUser.removeFromWishlist(itemId);
    } else {
      authenticationViewModel.currentUser.addToWishlist(itemId);
    }

    await userRepository.updateUserWishlist(
        userId, authenticationViewModel.currentUser.wishlist!);
    notifyListeners();
  }

  Future<void> addToCart({
    required String userId,
    required int productId,
    required String size,
    required int quantity,
    required double totalPrice,
  }) async {
    requestStatus = RequestStatus.loading;
    notifyListeners();
    try {
      authenticationViewModel.currentUser.addToCart(
        CartItem(
          productId: productId,
          size: size,
          quantity: quantity,
          totalPrice: totalPrice,
        ),
      );

      await userRepository.updateUserCart(
        userId,
        authenticationViewModel.currentUser.cart!,
      );
      requestStatus = RequestStatus.loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      requestStatus = RequestStatus.error;
      notifyListeners();
    }
  }

  Future<void> removeFromCart({
    required String userId,
    required int index,
  }) async {
    // requestStatus = RequestStatus.loading;
    // notifyListeners();

    try {
      authenticationViewModel.currentUser.removeFromCart(index);

      await userRepository.updateUserCart(
        userId,
        authenticationViewModel.currentUser.cart!,
      );

      // requestStatus = RequestStatus.loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      // requestStatus = RequestStatus.error;
      // notifyListeners();
    }
  }

  Future<void> increaseQuantityOfCartItem({
    required String userId,
    required int index,
  }) async {
    // requestStatus = RequestStatus.loading;
    // notifyListeners();
    try {
      authenticationViewModel.currentUser.increaseQuantityOfCartItem(
        index,
        (productId, newQuantity) {
          Product product = shopViewModel.getProductById(productId);
          authenticationViewModel.currentUser.cart?[index].totalPrice =
              product.price * newQuantity.toDouble();
        },
      );

      await userRepository.updateUserCart(
        userId,
        authenticationViewModel.currentUser.cart!,
      );

      // requestStatus = RequestStatus.loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      // requestStatus = RequestStatus.error;
      // notifyListeners();
    }
  }

  Future<void> decreaseQuantityOfCartItem({
    required String userId,
    required int index,
  }) async {
    // requestStatus = RequestStatus.loading;
    // notifyListeners();
    try {
      authenticationViewModel.currentUser.decreaseQuantityOfCartItem(
        index,
        (productId, newQuantity) {
          Product product = shopViewModel.getProductById(productId);
          authenticationViewModel.currentUser.cart?[index].totalPrice =
              product.price * newQuantity.toDouble();
        },
      );

      await userRepository.updateUserCart(
        userId,
        authenticationViewModel.currentUser.cart!,
      );

      // requestStatus = RequestStatus.loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      // requestStatus = RequestStatus.error;
      // notifyListeners();
    }
  }

  List<Product> getUserWishlist() {
    List<Product> shopData = shopViewModel.shopData;
    Set<int> wishlistItemIds = authenticationViewModel.currentUser.wishlist!;

    return shopData
        .where((product) => wishlistItemIds.contains(product.id))
        .toList();
  }

  double getCartTotalPrice() {
    return authenticationViewModel.currentUser.cart!
        .fold(0.0, (double total, CartItem item) => total + item.totalPrice);
  }

  Future<void> checkOut(String userId, Function() onFinish) async {
    requestStatus = RequestStatus.loading;
    notifyListeners();
    try {
      Order order = Order(
        items: authenticationViewModel.currentUser.cart!,
        orderPrice: getCartTotalPrice(),
        status: 'pending',
      );
      authenticationViewModel.currentUser.order!.add(order);
      await userRepository.updateUserOrder(
        userId,
        authenticationViewModel.currentUser.order!,
      );
      authenticationViewModel.currentUser.cart = [];
      await userRepository.updateUserCart(
        userId,
        authenticationViewModel.currentUser.cart!,
      );
      onFinish();
      requestStatus = RequestStatus.loaded;
      notifyListeners();
    } catch (e) {
      print(e);
      requestStatus = RequestStatus.error;
      notifyListeners();
    }
  }

  void _resetValues() {
    imagePath = "";
  }

  int getItemsCountPerOrder(int index) {
    return authenticationViewModel.currentUser.order![index].items
        .fold(0, (int total, CartItem item) => total + item.quantity);
  }
}
