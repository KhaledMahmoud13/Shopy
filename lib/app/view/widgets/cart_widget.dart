import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';
import 'package:shopy/core/util/utils.dart';

class CartWidget extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double price;
  final int quantity;
  final Function() downPressed;
  final Function() upPressed;
  final Function() removePressed;

  const CartWidget({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.quantity,
    required this.downPressed,
    required this.upPressed,
    required this.removePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.darkSlateGray,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s12),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSize.s8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)),
              child: Container(
                width: AppSize.s100,
                height: AppSize.s100,
                color: ColorManager.white2,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: AppSize.s14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(height: AppSize.s15),
                  Text(
                    '${currency()}$price',
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                  const SizedBox(height: AppSize.s15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: downPressed,
                            child: const Icon(
                              Icons.arrow_circle_down,
                              size: AppSize.s30,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: AppSize.s15),
                          Text(
                            '$quantity',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          const SizedBox(width: AppSize.s15),
                          GestureDetector(
                            onTap: upPressed,
                            child: const Icon(
                              Icons.arrow_circle_up,
                              size: AppSize.s30,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: removePressed,
                        child: const Icon(
                          CupertinoIcons.trash_circle,
                          size: AppSize.s30,
                          color: Colors.grey,
                        ),
                      ),
                    ],
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
