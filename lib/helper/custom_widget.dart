import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomWidgets {
  static const Color customGrey = Color(0xff9E9E9E);

  Widget customTextField(
    String name,
    TextEditingController controller,
    Widget prefixIcon,
    String? prefixText,
    TextInputType keyboardType,
    List<TextInputFormatter> textInputFormatter,
    String? suffixText,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: TextField(
              controller: controller,
              textCapitalization: TextCapitalization.characters,
              keyboardType: keyboardType,
              inputFormatters: textInputFormatter,
              decoration: InputDecoration(
                labelText: name,
                border: const OutlineInputBorder(),
                icon: prefixIcon,
                prefixText: prefixText,
                suffixText: suffixText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customListTile(
    Color tileColor,
    String title,
    VoidCallback func,
    String leading,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: ListTile(
        leading: Text(leading),
        onTap: func,
        tileColor: tileColor,
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios_rounded),
      ),
    );
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> customSnackBar(
      BuildContext context, String content) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(content)));
  }
}
