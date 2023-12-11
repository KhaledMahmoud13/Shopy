import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:shopy/app/view/widgets/default_button.dart';
import 'package:shopy/app/view/widgets/rounded_icon.dart';
import 'package:shopy/app/viewmodel/authentication_view_model.dart';
import 'package:shopy/app/viewmodel/shop_view_model.dart';
import 'package:shopy/app/viewmodel/user_view_model.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';
import 'package:shopy/core/util/enums.dart';
import 'package:shopy/core/util/extensions.dart';
import 'package:shopy/core/util/utils.dart';

class ProductDetailsView extends StatefulWidget {
  final int id;
  final String name;
  final int? price;
  final String gender;
  final String imageUrl;
  final String? weight;

  const ProductDetailsView({
    super.key,
    required this.id,
    required this.name,
    this.price,
    required this.gender,
    required this.imageUrl,
    this.weight,
  });

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  late final AuthenticationViewModel authenticationViewModel;
  late final UserViewModel userViewModel;
  late final ShopViewModel shopViewModel;

  @override
  void initState() {
    super.initState();
    authenticationViewModel =
        Provider.of<AuthenticationViewModel>(context, listen: false);
    userViewModel = Provider.of<UserViewModel>(context, listen: false);
    shopViewModel = Provider.of<ShopViewModel>(context, listen: false);
  }

  @override
  void dispose() {
    shopViewModel.resetValues();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: widget.price != null
          ? Consumer<UserViewModel>(
              builder: (context, value, child) => DefaultButton(
                child: value.requestStatus == RequestStatus.loading
                    ? const CircularProgressIndicator(
                        color: ColorManager.secondary)
                    : Text(
                        AppStrings.addToCart,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                onPressed: () async {
                  await userViewModel.addToCart(
                    userId:
                        authenticationViewModel.getCurrentFirebaseUser()!.uid,
                    productId: widget.id,
                    size: shopViewModel.selectedSize,
                    quantity: shopViewModel.quantity,
                    totalPrice:
                        widget.price! * shopViewModel.quantity.toDouble(),
                  );
                },
              ),
            )
          : null,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: AppSize.s400,
              elevation: 0,
              pinned: true,
              stretch: true,
              leading: RoundedIcon(
                margin: const EdgeInsets.only(
                  left: AppMargin.m8,
                  top: AppMargin.m8,
                  bottom: AppMargin.m4,
                ),
                icon: Icons.keyboard_backspace,
                backgroundColor: ColorManager.white2,
                iconColor: ColorManager.charcoalBlack,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                widget.weight == null
                    ? Consumer<UserViewModel>(
                        builder: (context, value, child) => RoundedIcon(
                          margin: const EdgeInsets.only(
                            right: AppMargin.m8,
                            top: AppMargin.m8,
                            bottom: AppMargin.m4,
                          ),
                          icon: widget.id.isProductInWishlist(
                                  authenticationViewModel.currentUser.wishlist!)
                              ? Icons.favorite
                              : Icons.favorite_outline,
                          backgroundColor: ColorManager.secondary,
                          iconColor: ColorManager.charcoalBlack,
                          onPressed: () async {
                            await userViewModel.updateWishlist(
                              userId: authenticationViewModel
                                  .getCurrentFirebaseUser()!
                                  .uid,
                              // wishlist: authenticationViewModel.currentUser.wishlist!,
                              itemId: widget.id,
                            );
                          },
                        ),
                      )
                    : Container(),
              ],
              backgroundColor: ColorManager.white,
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Column(
                      children: [
                        const SizedBox(height: AppSize.s5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.gender.toUpperCase(),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            Text(
                              widget.price != null
                                  ? AppStrings.price
                                  : AppStrings.weight,
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSize.s10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                widget.name,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ),
                            Text(
                              widget.price != null
                                  ? '${currency()}${widget.price}'
                                  : widget.weight!,
                              style: Theme.of(context).textTheme.displayLarge,
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSize.s25),
                        Align(
                          alignment: AlignmentDirectional.centerStart,
                          child: Text(
                            AppStrings.description,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        const SizedBox(height: AppSize.s5),
                        ReadMoreText(
                          AppStrings.lorem,
                          trimLines: 3,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'show more',
                          trimExpandedText: ' show less ',
                          lessStyle: Theme.of(context).textTheme.bodyMedium,
                          moreStyle: Theme.of(context).textTheme.bodyMedium,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        widget.price != null
                            ? Column(
                                children: [
                                  const SizedBox(height: AppSize.s20),
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      AppStrings.size,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  const SizedBox(height: AppSize.s5),
                                  Container(
                                    height: AppSize.s75,
                                    child: ListView.builder(
                                      padding: EdgeInsets.zero,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: AppStrings.sizes.length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            shopViewModel.toggleSize(
                                                AppStrings.sizes[index]);
                                          },
                                          child: Consumer<ShopViewModel>(
                                            builder: (context, value, child) =>
                                                Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s10),
                                                color: value.selectedSize ==
                                                        AppStrings.sizes[index]
                                                    ? ColorManager.primary
                                                    : ColorManager
                                                        .darkSlateGray,
                                              ),
                                              margin: index == 0
                                                  ? const EdgeInsets.only(
                                                      top: AppMargin.m4,
                                                      left: AppMargin.m0,
                                                      right: AppMargin.m4,
                                                      bottom: AppMargin.m4,
                                                    )
                                                  : const EdgeInsets.all(
                                                      AppMargin.m4),
                                              height: AppSize.s75,
                                              width: AppSize.s75,
                                              child: Center(
                                                child: Text(
                                                  AppStrings.sizes[index],
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyMedium,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(height: AppSize.s20),
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Text(
                                      AppStrings.quantity,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                  ),
                                  const SizedBox(height: AppSize.s5),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () => shopViewModel
                                                .increaseQuantity(),
                                            child: Container(
                                              width: AppSize.s50,
                                              height: AppSize.s50,
                                              decoration: BoxDecoration(
                                                color: ColorManager.primary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s8),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons.keyboard_arrow_up_sharp,
                                                  color: ColorManager.secondary,
                                                  size: AppSize.s30,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: AppSize.s15),
                                          Consumer<ShopViewModel>(
                                            builder: (context, value, child) =>
                                                Text(
                                              '${value.quantity}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            ),
                                          ),
                                          const SizedBox(width: AppSize.s15),
                                          GestureDetector(
                                            onTap: () => shopViewModel
                                                .decreaseQuantity(),
                                            child: Container(
                                              width: AppSize.s50,
                                              height: AppSize.s50,
                                              decoration: BoxDecoration(
                                                color: ColorManager.primary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        AppSize.s8),
                                              ),
                                              child: const Center(
                                                child: Icon(
                                                  Icons
                                                      .keyboard_arrow_down_sharp,
                                                  color: ColorManager.secondary,
                                                  size: AppSize.s30,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Consumer<ShopViewModel>(
                                        builder: (context, value, child) =>
                                            Text(
                                          '${currency()}${widget.price! * shopViewModel.quantity}',
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppSize.s20),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
