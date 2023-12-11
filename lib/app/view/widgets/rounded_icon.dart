import 'package:flutter/material.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';

class RoundedIcon extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  final Function() onPressed;
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;

  const RoundedIcon({
    super.key,
    required this.margin,
    required this.onPressed,
    required this.icon,
    this.backgroundColor = ColorManager.darkSlateGray,
    this.iconColor = ColorManager.secondary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: AppSize.s45,
      height: AppSize.s45,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(
          icon,
          size: AppSize.s30,
          color: iconColor,
        ),
      ),
    );
  }
}
