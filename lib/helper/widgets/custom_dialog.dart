import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    super.key,
    required this.finalWdgt,
    required this.customActions,
  });

  final Widget finalWdgt;
  final List<Widget> customActions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        padding: const EdgeInsets.all(10),
        child: finalWdgt,
      ),
      actions: customActions,
    );
  }
}
