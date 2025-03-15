import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextfieldLine extends StatelessWidget {
  const TextfieldLine({
    super.key,
    required this.controller,
    required this.header,
    required this.onChangeValue,
    this.formatter,
    this.lastWidget,
    this.textField,
    this.prefixText,
  });

  final TextEditingController controller;
  final Function(String? value) onChangeValue;
  final String header;
  final List<TextInputFormatter>? formatter;
  final Widget? lastWidget;
  final Widget? textField;
  final String? prefixText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white70,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: Text(header),
          ),
          const SizedBox(width: 50),
          Expanded(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: textField ??
                      TextField(
                        controller: controller,
                        onChanged: onChangeValue,
                        inputFormatters: formatter,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          prefixText: prefixText,
                        ),
                      ),
                ),
                const SizedBox(width: 20),
                lastWidget ?? const Text(""),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
