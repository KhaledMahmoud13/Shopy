import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/app/view/widgets/rounded_icon.dart';
import 'package:shopy/app/view/widgets/shop_item.dart';
import 'package:shopy/app/viewmodel/authentication_view_model.dart';
import 'package:shopy/app/viewmodel/user_view_model.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/routes_manager.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthenticationViewModel authenticationViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    final UserViewModel userViewModel =
        Provider.of<UserViewModel>(context, listen: false);
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
                icon: Icons.keyboard_backspace,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                AppStrings.wishlist,
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
                builder: (context, value, child) => Text(
                  '${value.getUserWishlist().length} ${AppStrings.items}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              const SizedBox(height: AppSize.s5),
              Text(
                AppStrings.inWishlist,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: AppSize.s20),
              Consumer<UserViewModel>(
                builder: (context, value, child) => GridView.builder(
                  itemCount: userViewModel.getUserWishlist().length,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2 / 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var item = userViewModel.getUserWishlist()[index];
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
                          itemId: userViewModel.getUserWishlist()[index].id,
                        );
                      },
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.productDetailsRoute,
                          arguments: userViewModel.getUserWishlist()[index],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
