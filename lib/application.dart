import 'package:flutter/material.dart';
import 'package:shopy/app/model/user_model.dart';
import 'package:shopy/app/viewmodel/authentication_view_model.dart';
import 'package:shopy/app/viewmodel/shop_view_model.dart';
import 'package:shopy/app/viewmodel/user_view_model.dart';
import 'package:shopy/core/resources/routes_manager.dart';
import 'package:shopy/core/resources/theme_manager.dart';
import 'package:provider/provider.dart';
import 'package:shopy/core/services/services_locator.dart';

class MyApplication extends StatelessWidget {
  const MyApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationViewModel>(
          create: (_) => getIt(),
        ),
        ChangeNotifierProvider<UserViewModel>(
          create: (_) => getIt(),
        ),
        ChangeNotifierProvider<ShopViewModel>(
          create: (_) => getIt(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        theme: getApplicationTheme(),
      ),
    );
  }
}
