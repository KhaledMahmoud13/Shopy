import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/app/viewmodel/user_view_model.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';
import 'package:shopy/core/util/extensions.dart';
import 'package:shopy/core/util/utils.dart';

class ShopItem extends StatelessWidget {
  final int id;
  final String name;
  final int? price;
  final String imageUrl;
  final Set<int>? wishlist;
  final Function()? onIconPressed;
  final Function() onPressed;

  const ShopItem({
    super.key,
    required this.id,
    required this.name,
    this.price,
    required this.imageUrl,
    this.wishlist,
    this.onIconPressed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s15),
              child: Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    // height: AppSize.s215,
                    height: 300,
                    width: double.infinity,
                    color: ColorManager.secondary,
                    child: CachedNetworkImage(
                      imageUrl: imageUrl,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Visibility(
                    visible: onIconPressed != null,
                    child: Padding(
                      padding: const EdgeInsets.all(AppPadding.p8),
                      child: GestureDetector(
                        onTap: onIconPressed,
                        child: Consumer<UserViewModel>(
                          builder: (context, value, child) => Icon(
                            id.isProductInWishlist(wishlist!)
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: Colors.grey,
                            size: AppSize.s30,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSize.s10),
          Text(
            name,
            style: Theme.of(context).textTheme.headlineMedium,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: AppSize.s4),
          Visibility(
            visible: price != null,
            child: Text(
              '${currency()}$price',
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
