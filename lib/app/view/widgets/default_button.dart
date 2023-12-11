import 'package:flutter/material.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';

class DefaultButton extends StatelessWidget {
  final Widget child;
  final double width;
  final double height;
  final Function()? onPressed;

  const DefaultButton({
    super.key,
    required this.child,
    this.width = double.infinity,
    this.height = AppSize.s75,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: ColorManager.primary,
      child: Material(
        color: ColorManager.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}
