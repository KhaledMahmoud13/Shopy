import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopy/app/view/widgets/rounded_icon.dart';
import 'package:shopy/app/view/widgets/shop_item.dart';
import 'package:shopy/app/viewmodel/shop_view_model.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/routes_manager.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';

class ForYouView extends StatelessWidget {
  const ForYouView({super.key});

  @override
  Widget build(BuildContext context) {
    final ShopViewModel shopViewModel =
        Provider.of<ShopViewModel>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
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
                AppStrings.forYou,
                style: Theme.of(context).textTheme.displayLarge,
              ),
              centerTitle: true,
            ),
          ],
          body: ListView(
            padding: const EdgeInsets.all(AppPadding.p8),
            physics: const ClampingScrollPhysics(),
            children: [
              Text(
                '${shopViewModel.measurementData.length} ${AppStrings.items}',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSize.s5),
              Text(
                AppStrings.inStock,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(height: AppSize.s20),
              GridView.builder(
                itemCount: shopViewModel.measurementData.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  var item = shopViewModel.measurementData[index];
                  return ShopItem(
                    id: item.id,
                    name: item.name,
                    imageUrl: item.imageUrl,
                    onPressed: () => Navigator.pushNamed(
                      context,
                      Routes.productDetailsRoute,
                      arguments: item,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
