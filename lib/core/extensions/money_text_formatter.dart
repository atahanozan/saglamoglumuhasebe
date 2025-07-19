import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class MoneyTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String newTextBeforeDot = newValue.text.contains(",")
        ? newValue.text.split(",")[0]
        : newValue.text;

    final String myText = newTextBeforeDot
        .replaceAll(".", "")
        .replaceAll(",", "")
        .replaceAll(RegExp("[a-zA-Z ]"), "");
    final int firstDot = (myText.characters.length % 3);

    final String lastText = firstDot == 1
        ? myText.replaceFirstMapped(
            RegExp(r".{1}"), (maped) => "${maped.group(0)}.")
        : firstDot == 2
            ? myText.replaceFirstMapped(
                RegExp(r".{2}"), (maped) => "${maped.group(0)}.")
            : myText;

    final String decimals = firstDot != 0 ? lastText.split(".")[1] : myText;
    final String firstDecimals = lastText.split(".")[0];

    final String newText = decimals.replaceAllMapped(
        RegExp(r".{3}"), (maped) => "${maped.group(0)}.");

    final String decimalNumber =
        firstDot != 0 ? "$firstDecimals.$newText" : newText;

    final String result = myText.characters.length > 3 ? decimalNumber : myText;

    final String lastResult = result.endsWith(".")
        ? result.replaceRange((result.characters.length - 1), null, "")
        : result;

    return TextEditingValue(
      text: lastResult,
      selection: TextSelection.collapsed(offset: lastResult.length),
    );
  }
}
