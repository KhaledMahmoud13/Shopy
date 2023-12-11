import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/app/view/widgets/rounded_icon.dart';
import 'package:shopy/app/viewmodel/authentication_view_model.dart';
import 'package:shopy/app/viewmodel/shop_view_model.dart';
import 'package:shopy/app/viewmodel/user_view_model.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';
import 'package:shopy/core/util/utils.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

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
                icon: Icons.keyboard_backspace,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                AppStrings.order,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              centerTitle: true,
            ),
          ],
          body: ListView.builder(
            padding: const EdgeInsets.all(AppPadding.p8),
            physics: const ClampingScrollPhysics(),
            itemCount: authenticationViewModel.currentUser.order?.length,
            itemBuilder: (context, listviewIndex) => Card(
              color: ColorManager.darkSlateGray,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSize.s12),
              ),
              child: Container(
                padding: const EdgeInsets.all(AppSize.s8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: AppSize.s100,
                      child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(AppSize.s8)),
                        child: authenticationViewModel.currentUser
                                    .order![listviewIndex].items.length ==
                                1
                            ? Container(
                                width: AppSize.s100,
                                height: AppSize.s110,
                                color: ColorManager.white2,
                                child: CachedNetworkImage(
                                  imageUrl: shopViewModel
                                      .getProductById(
                                        authenticationViewModel
                                            .currentUser
                                            .order![listviewIndex]
                                            .items[0]
                                            .productId,
                                      )
                                      .imageUrl,
                                  fit: BoxFit.contain,
                                ),
                              )
                            : authenticationViewModel.currentUser
                                        .order![listviewIndex].items.length ==
                                    2
                                ? Row(
                                    children: [
                                      Container(
                                        width: AppSize.s47_5,
                                        height: AppSize.s110,
                                        color: ColorManager.white2,
                                        child: CachedNetworkImage(
                                          imageUrl: shopViewModel
                                              .getProductById(
                                                authenticationViewModel
                                                    .currentUser
                                                    .order![listviewIndex]
                                                    .items[0]
                                                    .productId,
                                              )
                                              .imageUrl,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      const SizedBox(width: AppSize.s5),
                                      Container(
                                        width: AppSize.s47_5,
                                        height: AppSize.s110,
                                        color: ColorManager.white2,
                                        child: CachedNetworkImage(
                                          imageUrl: shopViewModel
                                              .getProductById(
                                                authenticationViewModel
                                                    .currentUser
                                                    .order![listviewIndex]
                                                    .items[1]
                                                    .productId,
                                              )
                                              .imageUrl,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ],
                                  )
                                : GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: authenticationViewModel
                                                .currentUser
                                                .order![listviewIndex]
                                                .items
                                                .length >
                                            4
                                        ? 4
                                        : authenticationViewModel.currentUser
                                            .order?[listviewIndex].items.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      childAspectRatio: 0.8,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5,
                                    ),
                                    itemBuilder: (context, index) => Container(
                                      color: ColorManager.white2,
                                      child: CachedNetworkImage(
                                        imageUrl: shopViewModel
                                            .getProductById(
                                              authenticationViewModel
                                                  .currentUser
                                                  .order![listviewIndex]
                                                  .items[index]
                                                  .productId,
                                            )
                                            .imageUrl,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                      ),
                    ),
                    const SizedBox(width: AppSize.s10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: AppStrings.status,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              TextSpan(
                                text: authenticationViewModel
                                    .currentUser.order![listviewIndex].status
                                    .toUpperCase(),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSize.s10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: AppStrings.priceCol,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              TextSpan(
                                text:
                                    '${authenticationViewModel.currentUser.order![listviewIndex].orderPrice}${currency()}',
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSize.s10),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: AppStrings.itemCount,
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              TextSpan(
                                text: userViewModel
                                    .getItemsCountPerOrder(listviewIndex)
                                    .toString(),
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
