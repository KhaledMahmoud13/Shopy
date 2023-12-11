import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/app/view/widgets/drawer_item.dart';
import 'package:shopy/app/view/widgets/recommendation_item.dart';
import 'package:shopy/app/view/widgets/rounded_icon.dart';
import 'package:shopy/app/view/widgets/shop_item.dart';
import 'package:shopy/app/viewmodel/authentication_view_model.dart';
import 'package:shopy/app/viewmodel/shop_view_model.dart';
import 'package:shopy/app/viewmodel/user_view_model.dart';
import 'package:shopy/core/resources/assets_manager.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/font_manager.dart';
import 'package:shopy/core/resources/routes_manager.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';
import 'package:shopy/core/util/utils.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationViewModel authenticationViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    final UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);
    final ShopViewModel shopViewModel =
        Provider.of<ShopViewModel>(context, listen: false);
    return Scaffold(
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
                onPressed: () => Scaffold.of(context).openDrawer(),
                icon: Icons.clear_all_rounded,
              ),
              actions: [
                RoundedIcon(
                  margin: const EdgeInsets.only(right: AppMargin.m8),
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.cartRoute);
                  },
                  icon: Icons.shopping_cart_outlined,
                ),
              ],
            ),
          ],
          body: ListView(
            padding: const EdgeInsets.all(AppPadding.p8),
            physics: const ClampingScrollPhysics(),
            children: [
              Text(
                AppStrings.hello,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: AppSize.s10),
              Text(
                AppStrings.welcomeToShopy,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: FontSize.s30),
              Text(
                AppStrings.recommendation,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: AppSize.s20),
              SizedBox(
                height: AppSize.s220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: shopViewModel.measurementData.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: AppSize.s10),
                  itemBuilder: (context, index) {
                    var item = shopViewModel.measurementData[index];
                    return RecommendationItem(
                      name: item.name,
                      imageUrl: item.imageUrl,
                      price: item.price.toString(),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        Routes.productDetailsRoute,
                        arguments: item,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s10),
              Text(
                AppStrings.newArrival,
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: AppSize.s20),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: shopViewModel.shopData.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  var item = shopViewModel.shopData[index];
                  return ShopItem(
                    id: item.id,
                    imageUrl: item.imageUrl,
                    name: item.name,
                    price: item.price,
                    wishlist: authenticationViewModel.currentUser.wishlist!,
                    onIconPressed: () async {
                      await userViewModel.updateWishlist(
                        userId: authenticationViewModel
                            .getCurrentFirebaseUser()!
                            .uid,
                        // wishlist: authenticationViewModel.currentUser.wishlist!,
                        itemId: shopViewModel.shopData[index].id,
                      );
                    },
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        Routes.productDetailsRoute,
                        arguments: shopViewModel.shopData[index],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: ColorManager.background,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSize.s12),
                Container(
                  width: AppSize.s45,
                  height: AppSize.s45,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorManager.darkSlateGray,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.clear_all_rounded,
                        size: AppSize.s30,
                        color: ColorManager.secondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s30),
                Consumer<AuthenticationViewModel>(
                  builder: (context, value, child) => Row(
                    children: [
                      CircleAvatar(
                        radius: AppSize.s35,
                        backgroundColor: ColorManager.secondary,
                        backgroundImage: authenticationViewModel
                                    .currentUser.profilePicture !=
                                null
                            ? NetworkImage(
                                authenticationViewModel
                                    .currentUser.profilePicture!,
                              )
                            : const AssetImage(ImageAssets.placeholder)
                                as ImageProvider,
                      ),
                      const SizedBox(width: AppSize.s15),
                      Expanded(
                        child: Text(
                          authenticationViewModel.currentUser.fullName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSize.s20),
                DrawerItem(
                  icon: Icons.info_outline,
                  iconColor: ColorManager.secondary,
                  text: AppStrings.accountInformation,
                  textStyle: Theme.of(context).textTheme.headlineSmall!,
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      Routes.accountInformationRoute,
                    );
                  },
                ),
                // DrawerItem(
                //   icon: Icons.lock_outline,
                //   iconColor: ColorManager.secondary,
                //   text: AppStrings.password,
                //   textStyle: Theme.of(context).textTheme.headlineSmall!,
                //   onPressed: () {},
                // ),
                DrawerItem(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: ColorManager.secondary,
                  text: AppStrings.cart,
                  textStyle: Theme.of(context).textTheme.headlineSmall!,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.cartRoute);
                  },
                ),
                DrawerItem(
                  icon: Icons.shopping_bag_outlined,
                  iconColor: ColorManager.secondary,
                  text: AppStrings.order,
                  textStyle: Theme.of(context).textTheme.headlineSmall!,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.orderRoute);
                  },
                ),
                DrawerItem(
                  icon: Icons.favorite_outline,
                  iconColor: ColorManager.secondary,
                  text: AppStrings.wishlist,
                  textStyle: Theme.of(context).textTheme.headlineSmall!,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.wishlistRoute);
                  },
                ),
                // DrawerItem(
                //   icon: Icons.card_giftcard,
                //   iconColor: ColorManager.secondary,
                //   text: AppStrings.forYou,
                //   textStyle: Theme.of(context).textTheme.headlineSmall!,
                //   onPressed: () {
                //     Navigator.pushNamed(context, Routes.forYouRoute);
                //   },
                // ),
                const SizedBox(height: AppSize.s80),
                DrawerItem(
                  icon: Icons.logout,
                  iconColor: ColorManager.red,
                  text: AppStrings.logout,
                  textStyle: Theme.of(context).textTheme.titleSmall!,
                  onPressed: () {
                    authenticationViewModel.signOut(
                      () => Navigator.pushReplacementNamed(
                        context,
                        Routes.loginRoute,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
