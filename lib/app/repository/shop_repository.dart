import 'package:firebase_database/firebase_database.dart';
import 'package:shopy/app/model/product.dart';
import 'package:shopy/app/model/recommendation.dart';
import 'package:shopy/core/util/constants.dart';
import 'package:shopy/core/util/extensions.dart';

class ShopRepository {
  final _shopRef = FirebaseDatabase.instance.ref(Constants.shopPath);
  final _recommendationRef =
      FirebaseDatabase.instance.ref(Constants.recommendationPath);
  final _measurementRef =
      FirebaseDatabase.instance.ref(Constants.measurementPath);

  Future<List<Product>> getShopData() async {
    DatabaseEvent shopEvent = await _shopRef.once();
    return List<Product>.from(
      (shopEvent.snapshot.value as List).map((e) => Product.fromValue(e)),
    );
  }

  // Future<List<Recommendation>> getRecommendationData(String gender) async {
  //   Query query =
  //       _recommendationRef.orderByChild(Constants.genderChild).equalTo(gender);
  //   DatabaseEvent shopEvent = await query.once();
  //   return List<Recommendation>.from(
  //     (shopEvent.snapshot.value as List)
  //         .where((element) => element != null)
  //         .map((e) => Recommendation.fromValue(e)),
  //   );
  // }

  Future<List<Product>> getMeasurementData(double userWeight) async {
    Query query = _measurementRef
        .orderByChild(Constants.weightChild)
        .equalTo(userWeight.getUserWeight());
    DatabaseEvent shopEvent = await query.once();
    if (shopEvent.snapshot.value is List) {
      return List<Product>.from(
        (shopEvent.snapshot.value as List)
            .where((element) => element != null)
            .map((e) => Product.fromValue(e)),
      );
    } else {
      return List<Product>.from(
        (shopEvent.snapshot.value as Map)
            .values
            .where((element) => element != null)
            .map((e) => Product.fromValue(e)),
      );
    }
  }
}
