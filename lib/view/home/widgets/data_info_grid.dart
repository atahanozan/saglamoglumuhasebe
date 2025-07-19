import 'package:flutter/material.dart';

class DataInfoGrid extends StatelessWidget {
  const DataInfoGrid({
    super.key,
    this.firsWidget,
    this.secondWidget,
    this.thirdWidget,
  });

  final Widget? firsWidget;
  final Widget? secondWidget;
  final Widget? thirdWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Expanded(
            child: firsWidget ?? SizedBox(),
          ),
          SizedBox(width: 50),
          Expanded(
            child: secondWidget ?? SizedBox(),
          ),
        ],
      ),
    );
  }
}
