import 'package:flutter/services.dart';

class MoneyTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String myText = newValue.text.replaceAll(".", "");

    final String newText = myText.replaceAllMapped(
        RegExp(r".{3}"), (maped) => "${maped.group(0)}.");

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
