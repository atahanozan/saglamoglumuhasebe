import 'package:flutter/material.dart';

class CustomDatePicker {
  Future<DateTime?> customDateTimePicker(
    BuildContext context,
    DateTime firstDate,
    DateTime lastDate,
  ) async {
    return showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }
}
