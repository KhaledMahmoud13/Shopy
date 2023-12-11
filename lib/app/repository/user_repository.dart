import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopy/app/model/cart_item.dart';
import 'package:shopy/app/model/user_model.dart';
import 'package:shopy/app/services/storage_services.dart';
import 'package:shopy/core/util/constants.dart';
import 'package:shopy/app/model/order.dart' as orderItem;

class UserRepository {
  final StorageServices storageServices;

  UserRepository({required this.storageServices});

  final _database = FirebaseFirestore.instance;

  Future<UserModel?> getUser(String userId) async {
    try {
      var document = await _database
          .collection(Constants.usersCollection)
          .doc(userId)
          .get();
      return UserModel.fromDocument(document.data()!);
    } catch (e) {
      print('Error auth repo $e');
      return null;
    }
  }

  Future<String?> updateUser(
      String userId, UserModel user, String imagePath) async {
    try {
      String? imageUrl;
      if (imagePath != '') {
        imageUrl = await storageServices.uploadImage(imagePath, userId);
        user.profilePicture = imageUrl;
        print(imageUrl);
      }
      await _database
          .collection(Constants.usersCollection)
          .doc(userId)
          .update(user.updateUser());
      return imageUrl;
    } catch (e) {
      print('Error update user $e');
      return null;
    }
  }

  Future<void> updateUserWishlist(String userId, Set<int> wishlist) async {
    try {
      await _database
          .collection(Constants.usersCollection)
          .doc(userId)
          .update({'wishlist': wishlist});
    } catch (e) {
      print('Error update wishlist $e');
    }
  }

  Future<void> updateUserCart(String userId, List<CartItem> cart) async {
    try {
      await _database
          .collection(Constants.usersCollection)
          .doc(userId)
          .update({'cart': cart.map((item) => item.toDocument())});
    } catch (e) {
      print('Error update cart $e');
    }
  }

  Future<void> updateUserOrder(String userId, List<orderItem.Order> order) async {
    try {
      await _database
          .collection(Constants.usersCollection)
          .doc(userId)
          .update({'order': order.map((item) => item.toDocument())});
    } catch (e) {
      print('Error update orders $e');
    }
  }
}
