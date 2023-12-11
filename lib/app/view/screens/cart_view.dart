import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/app/view/widgets/cart_widget.dart';
import 'package:shopy/app/view/widgets/default_button.dart';
import 'package:shopy/app/view/widgets/rounded_icon.dart';
import 'package:shopy/app/viewmodel/authentication_view_model.dart';
import 'package:shopy/app/viewmodel/shop_view_model.dart';
import 'package:shopy/app/viewmodel/user_view_model.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/routes_manager.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';
import 'package:shopy/core/util/enums.dart';
import 'package:shopy/core/util/utils.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationViewModel authenticationViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    final UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);
    final ShopViewModel shopViewModel =
        Provider.of<ShopViewModel>(context, listen: false);
    return Scaffold(
      bottomNavigationBar: Consumer<UserViewModel>(
        builder: (context, value, child) => DefaultButton(
          onPressed: authenticationViewModel.currentUser.cart!.isEmpty ||
                  authenticationViewModel.currentUser.cart == null
              ? null
              : () async {
                  await value.checkOut(
                    authenticationViewModel.getCurrentFirebaseUser()!.uid,
                    () {
                      Navigator.pushReplacementNamed(
                        context,
                        Routes.orderConfirmedRoute,
                      );
                    },
                  );
                },
          child: value.requestStatus == RequestStatus.loading
              ? const CircularProgressIndicator(color: ColorManager.secondary)
              : Text(
                  AppStrings.checkout,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
        ),
      ),
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            SliverAppBar(
              floating: true,
              toolbarHeight: AppSize.s90,
              backgroundColor: ColorManager.background,
              elevation: 0,
              expandedHeight: AppSize.s90,
              leading: RoundedIcon(
                margin: const EdgeInsets.only(left: AppMargin.m8),
                icon: Icons.keyboard_backspace,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                AppStrings.cart,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              centerTitle: true,
            ),
          ],
          body: ListView(
            padding: const EdgeInsets.all(AppPadding.p8),
            physics: const ClampingScrollPhysics(),
            children: [
              Consumer<UserViewModel>(
                builder: (context, value, child) => ListView.builder(
                  itemCount: authenticationViewModel.currentUser.cart?.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => CartWidget(
                    imageUrl: shopViewModel
                        .getProductById(authenticationViewModel
                            .currentUser.cart![index].productId)
                        .imageUrl,
                    name: shopViewModel
                        .getProductById(authenticationViewModel
                            .currentUser.cart![index].productId)
                        .name,
                    price: authenticationViewModel
                        .currentUser.cart![index].totalPrice,
                    quantity: authenticationViewModel
                        .currentUser.cart![index].quantity,
                    downPressed: () async {
                      await userViewModel.decreaseQuantityOfCartItem(
                        userId: authenticationViewModel
                            .getCurrentFirebaseUser()!
                            .uid,
                        index: index,
                      );
                    },
                    upPressed: () async {
                      await userViewModel.increaseQuantityOfCartItem(
                        userId: authenticationViewModel
                            .getCurrentFirebaseUser()!
                            .uid,
                        index: index,
                      );
                    },
                    removePressed: () async {
                      await userViewModel.removeFromCart(
                        userId: authenticationViewModel
                            .getCurrentFirebaseUser()!
                            .uid,
                        index: index,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s10),
              Text(
                AppStrings.orderInfo,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: AppSize.s15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.subtotal,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Consumer<UserViewModel>(
                    builder: (context, value, child) => Text(
                      '${currency()}${userViewModel.getCartTotalPrice()}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.shippingCost,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Text(
                    '${currency()}0.0',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppStrings.totalPrice,
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  Consumer<UserViewModel>(
                    builder: (context, value, child) => Text(
                      '${currency()}${userViewModel.getCartTotalPrice()}',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
