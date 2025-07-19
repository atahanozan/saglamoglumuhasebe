import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormfieldWidget extends StatelessWidget {
  const CustomFormfieldWidget({
    super.key,
    required this.formName,
    required this.inputFormatter,
    required this.controller,
    this.labelColor,
    this.hint = "",
  });

  final String formName;
  final List<TextInputFormatter> inputFormatter;
  final TextEditingController controller;
  final Color? labelColor;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          formName,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: labelColor ?? Colors.white),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: hint,
            ),
            inputFormatters: inputFormatter,
          ),
        ),
      ],
    );
  }
}
