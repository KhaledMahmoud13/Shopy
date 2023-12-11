import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopy/app/view/widgets/default_button.dart';
import 'package:shopy/core/resources/assets_manager.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/routes_manager.dart';
import 'package:shopy/core/resources/strings_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';

class OrderConfirmedView extends StatelessWidget {
  const OrderConfirmedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppPadding.p8),
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(height: AppSize.s200),
            SizedBox(
              width: double.infinity,
              child: SvgPicture.asset(
                ImageAssets.orderConfirmed,
              ),
            ),
            const SizedBox(height: AppSize.s20),
            Text(
              AppStrings.orderConfirmed,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: AppSize.s10),
            Text(
              AppStrings.orderConfirmedMessage,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
      bottomNavigationBar: DefaultButton(
        child: Text(
          AppStrings.continueShopping,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        onPressed: () {
          Navigator.pushReplacementNamed(context, Routes.homeRoute);
        },
      ),
    );
  }
}
