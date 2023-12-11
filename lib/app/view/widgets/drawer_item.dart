import 'package:flutter/material.dart';
import 'package:shopy/core/resources/color_manager.dart';
import 'package:shopy/core/resources/values_manager.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String text;
  final TextStyle textStyle;
  final Function() onPressed;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.text,
    required this.textStyle,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            margin: const EdgeInsets.fromLTRB(
              AppMargin.m0,
              AppMargin.m12,
              AppMargin.m12,
              AppMargin.m12,
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: iconColor,
                  size: AppSize.s30,
                ),
                const SizedBox(width: AppSize.s10),
                Text(
                  text,
                  style: textStyle,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
