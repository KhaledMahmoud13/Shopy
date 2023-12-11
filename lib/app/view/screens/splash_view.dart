import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shopy/app/viewmodel/authentication_view_model.dart';
import 'package:shopy/app/viewmodel/shop_view_model.dart';
import 'package:shopy/core/resources/assets_manager.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/routes_manager.dart';
import 'package:shopy/core/util/enums.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late final AuthenticationViewModel authenticationViewModel;
  late final ShopViewModel shopViewModel;

  @override
  void initState() {
    super.initState();
    authenticationViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    shopViewModel = Provider.of<ShopViewModel>(context, listen: false);

    if (authenticationViewModel.checkAuthenticationStatus() ==
            AuthenticationStatus.authenticated &&
        authenticationViewModel.getCurrentFirebaseUser()!.emailVerified) {
      Future.delayed(
        const Duration(seconds: 1),
        () async {
          await authenticationViewModel.getCurrentUser(
            authenticationViewModel.getCurrentFirebaseUser()!.uid,
          );
          await Future.wait([
            // shopViewModel.getRecommendationData(
            //   authenticationViewModel.currentUser.gender,
            // ),
            shopViewModel.getShopData(),
            shopViewModel.getMeasurementData(
              authenticationViewModel.currentUser.weight,
              authenticationViewModel.currentUser.gender,
            ),
          ]);
          Navigator.pushReplacementNamed(context, Routes.homeRoute);
        },
      );
    } else {
      Future.delayed(
        const Duration(seconds: 1),
        () => Navigator.pushReplacementNamed(context, Routes.loginRoute),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(ImageAssets.logo),
      ),
    );
  }
}
