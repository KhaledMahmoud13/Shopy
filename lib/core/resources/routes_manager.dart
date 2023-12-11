import 'package:flutter/material.dart';
import 'package:shopy/app/model/product.dart';
import 'package:shopy/app/model/recommendation.dart';
import 'package:shopy/app/view/screens/account_information_view.dart';
import 'package:shopy/app/view/screens/cart_view.dart';
import 'package:shopy/app/view/screens/for_you_view.dart';
import 'package:shopy/app/view/screens/forgot_password_view.dart';
import 'package:shopy/app/view/screens/home_view.dart';
import 'package:shopy/app/view/screens/login_view.dart';
import 'package:shopy/app/view/screens/order_confirmed_view.dart';
import 'package:shopy/app/view/screens/order_view.dart';
import 'package:shopy/app/view/screens/product_details_view.dart';
import 'package:shopy/app/view/screens/signup_view.dart';
import 'package:shopy/app/view/screens/splash_view.dart';
import 'package:shopy/app/view/screens/wishlist_view.dart';
import 'package:shopy/core/resources/strings_manager.dart';

class Routes {
  static const String splashRoute = "/";
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String homeRoute = "/home";
  static const String forgotPasswordRoute = "/forgot-password";
  static const String accountInformationRoute = "/account-information";
  static const String wishlistRoute = "/wishlist";
  static const String productDetailsRoute = "/product-details";
  static const String cartRoute = "/cart";
  static const String forYouRoute = "/for-you";
  static const String orderRoute = "/order";
  static const String orderConfirmedRoute = "/order-confirmed";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_) => SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_) => SignUpView());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgotPasswordView());
      case Routes.accountInformationRoute:
        return MaterialPageRoute(builder: (_) => AccountInformationView());
      case Routes.wishlistRoute:
        return MaterialPageRoute(builder: (_) => WishlistView());
      case Routes.productDetailsRoute:
        final dynamic product = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsView(
            id: product.id,
            name: product.name,
            price: product.price,
            gender: product.gender,
            imageUrl: product.imageUrl,
            weight: settings.arguments is Product ? product.weight : null,
          ),
        );
      case Routes.cartRoute:
        return MaterialPageRoute(builder: (_) => CartView());
      case Routes.forYouRoute:
        return MaterialPageRoute(builder: (_) => ForYouView());
      case Routes.orderRoute:
        return MaterialPageRoute(builder: (_) => OrderView());
      case Routes.orderConfirmedRoute:
        return MaterialPageRoute(builder: (_) => OrderConfirmedView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: const Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
