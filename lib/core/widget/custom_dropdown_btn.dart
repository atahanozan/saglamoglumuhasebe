import 'package:flutter/material.dart';

class CustomDropdownBtn extends StatelessWidget {
  const CustomDropdownBtn({
    super.key,
    required this.btnItems,
    required this.btnOnchanged,
    required this.btnValue,
  });

  final List<String> btnItems;
  final String btnValue;
  final Function(String?) btnOnchanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: SizedBox(),
      value: btnValue,
      items: List.generate(btnItems.length, (index) {
        return DropdownMenuItem(
          value: btnItems[index],
          child: Text(btnItems[index]),
        );
      }),
      onChanged: btnOnchanged,
    );
  }
}
