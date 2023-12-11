import 'package:get_it/get_it.dart';
import 'package:shopy/app/repository/authentication_repository.dart';
import 'package:shopy/app/repository/shop_repository.dart';
import 'package:shopy/app/repository/user_repository.dart';
import 'package:shopy/app/services/storage_services.dart';
import 'package:shopy/app/viewmodel/authentication_view_model.dart';
import 'package:shopy/app/viewmodel/shop_view_model.dart';
import 'package:shopy/app/viewmodel/user_view_model.dart';

final getIt = GetIt.instance;

class ServicesLocator {
  void init() {
    getIt.registerLazySingleton(
      () => AuthenticationRepository(storageServices: getIt()),
    );
    getIt.registerLazySingleton(
      () => UserRepository(storageServices: getIt()),
    );
    getIt.registerLazySingleton(
      () => ShopRepository(),
    );
    getIt.registerLazySingleton(() => StorageServices());
    getIt.registerLazySingleton(
      () => AuthenticationViewModel(
        authenticationRepository: getIt(),
        userRepository: getIt(),
      ),
    );
    getIt.registerLazySingleton(
      () => UserViewModel(
        userRepository: getIt(),
        authenticationViewModel: getIt(),
        shopViewModel: getIt(),
      ),
    );
    getIt.registerLazySingleton(() => ShopViewModel(shopRepository: getIt()));
  }
}
