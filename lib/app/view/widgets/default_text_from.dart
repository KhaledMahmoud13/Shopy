import 'package:flutter/material.dart';
import 'package:shopy/core/resources/color_manager.dart';

class DefaultTextForm extends StatelessWidget {
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final String? Function(String?) validate;
  final bool enabled;
  final String? hint;
  final bool readOnly;
  final Function()? onTap;

  const DefaultTextForm({
    super.key,
    required this.controller,
    this.isPassword = false,
    required this.keyboardType,
    required this.validate,
    this.enabled = true,
    this.hint,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      enabled: enabled,
      readOnly: readOnly,
      validator: validate,
      onTap: onTap,
      cursorColor: ColorManager.grey,
      style: Theme.of(context).textTheme.titleMedium,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }
}
