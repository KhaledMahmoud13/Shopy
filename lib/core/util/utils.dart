import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shopy/core/resources/color_manager.dart';

String currency() {
  var format = NumberFormat.simpleCurrency(locale: 'en_US');
  return format.currencySymbol;
}

Future<void> selectBirthDate(BuildContext context, DateTime selectedDate, TextEditingController controller) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    builder: (context, child) => Theme(
      data: Theme.of(context).copyWith(
        colorScheme: const ColorScheme.dark(
          onSurface: ColorManager.secondary,
        ),
      ),
      child: child!,
    ),
  );
  if (picked != null && picked != selectedDate) {
    selectedDate = picked;
    controller.text = DateFormat.yMMMMd().format(picked);
  }
}