import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.btnValue,
    required this.onchangeFun,
    required this.valueList,
  });

  final String btnValue;
  final List<String> valueList;
  final Function(String? value) onchangeFun;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(15),
      ),
      child: DropdownButton(
        elevation: 0,
        borderRadius: BorderRadius.circular(15),
        alignment: Alignment.centerLeft,
        value: btnValue,
        underline: Text(""),
        items: valueList
            .map((String companies) => DropdownMenuItem(
                  value: companies,
                  child: Text(
                    companies,
                  ),
                ))
            .toList(),
        onChanged: onchangeFun,
      ),
    );
  }
}
