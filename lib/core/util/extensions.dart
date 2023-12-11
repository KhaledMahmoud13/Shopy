import 'package:shopy/core/resources/strings_manager.dart';

extension ProductWishList on int {
  bool isProductInWishlist(Set<int> wishlist) {
    return wishlist.any((id) => this == id);
  }
}

extension UserWeight on double {
  String getUserWeight() {
    if (this >= 50 && this <= 70) {
      return AppStrings.from50To70;
    } else if (this > 70 && this <= 90) {
      return AppStrings.from70To90;
    } else if (this > 90) {
      return AppStrings.over90;
    } else {
      return AppStrings.unKnownWeight;
    }
  }
}
