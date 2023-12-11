import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';
import 'package:shopy/core/util/utils.dart';

class RecommendationItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final Function() onPressed;

  const RecommendationItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: AppSize.s150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s15),
              child: Container(
                height: AppSize.s150,
                width: AppSize.s150,
                color: ColorManager.secondary,
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                ),
              ),
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              name,
              style: Theme.of(context).textTheme.labelMedium,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Text(
              '${currency()}$price',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }
}
