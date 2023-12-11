import 'package:flutter/material.dart';
import 'package:shopy/app/model/product.dart';
import 'package:shopy/app/model/recommendation.dart';
import 'package:shopy/app/repository/shop_repository.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/util/enums.dart';

class ShopViewModel with ChangeNotifier {
  final ShopRepository shopRepository;

  ShopViewModel({required this.shopRepository});

  RequestStatus requestStatus = RequestStatus.initial;

  // late List<Recommendation> recommendationData;
  late List<Product> shopData;
  late List<Product> measurementData;
  String selectedSize = AppStrings.sizes[0];
  int quantity = 1;

  // Future<void> getRecommendationData(String gender) async {
  //   requestStatus = RequestStatus.loading;
  //   notifyListeners();
  //   try {
  //     recommendationData = await shopRepository.getRecommendationData(gender);
  //     requestStatus = RequestStatus.loaded;
  //     notifyListeners();
  //   } catch (e) {
  //     print('Error during fetch recommendation: $e');
  //     requestStatus = RequestStatus.error;
  //     notifyListeners();
  //   }
  // }

  Future<void> getShopData() async {
    requestStatus = RequestStatus.loading;
    notifyListeners();
    try {
      shopData = await shopRepository.getShopData();
      requestStatus = RequestStatus.loaded;
      notifyListeners();
    } catch (e) {
      print('Error during fetch recommendation: $e');
      requestStatus = RequestStatus.error;
      notifyListeners();
    }
  }

  Future<void> getMeasurementData(double userWeight, String userGender) async {
    requestStatus = RequestStatus.loading;
    notifyListeners();
    try {
      List<Product> measurementsList =
          await shopRepository.getMeasurementData(userWeight);
      measurementData = measurementsList
          .where((element) => element.gender == userGender)
          .toList();
      requestStatus = RequestStatus.loaded;
      notifyListeners();
    } catch (e) {
      print('Error during fetch measurement: $e');
      requestStatus = RequestStatus.error;
      notifyListeners();
    }
  }

  Product getProductById(int id) {
    return id > 20
        ? measurementData.singleWhere((element) => element.id == id)
        : shopData.singleWhere((element) => element.id == id);
  }

  void toggleSize(String selectedSize) {
    this.selectedSize = selectedSize;
    notifyListeners();
  }

  void increaseQuantity() {
    if (quantity == 5) {
      return;
    }
    quantity++;
    notifyListeners();
  }

  void decreaseQuantity() {
    if (quantity == 1) {
      return;
    }
    quantity--;
    notifyListeners();
  }

  void resetValues() {
    selectedSize = AppStrings.sizes[0];
    quantity = 1;
  }
}
