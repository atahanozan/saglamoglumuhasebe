import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormfieldWidget extends StatelessWidget {
  const CustomFormfieldWidget({
    super.key,
    required this.formName,
    required this.inputFormatter,
    required this.controller,
    required this.isPassword,
    this.labelColor,
    this.hint = "",
    required this.isObsecure,
    this.obsecureFunction,
  });

  final String formName;
  final List<TextInputFormatter> inputFormatter;
  final TextEditingController controller;
  final Color? labelColor;
  final String? hint;
  final bool isPassword;
  final VoidCallback? obsecureFunction;
  final bool isObsecure;

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
            obscureText: isObsecure,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              hintText: hint,
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: obsecureFunction,
                      icon: Icon(isObsecure == true
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined))
                  : SizedBox(),
            ),
            inputFormatters: inputFormatter,
          ),
        ),
      ],
    );
  }
}
