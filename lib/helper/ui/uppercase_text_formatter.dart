import 'package:flutter/services.dart';

class UppercaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.replaceAll("i", "İ").toUpperCase(),
      selection: newValue.selection,
    );
  }
}
