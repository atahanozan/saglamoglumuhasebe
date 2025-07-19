import 'package:flutter/material.dart';

class CustomContainerButton extends StatelessWidget {
  const CustomContainerButton({
    super.key,
    this.btnHeight = 30,
    this.btnWidth = 100,
    this.btnDecoration,
    required this.btnName,
    required this.onBtnTab,
  });

  final double btnHeight;
  final double btnWidth;
  final BoxDecoration? btnDecoration;
  final Widget btnName;
  final VoidCallback onBtnTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onBtnTab,
      child: Container(
        height: btnHeight,
        width: btnWidth,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: const EdgeInsets.all(5),
        decoration: btnDecoration,
        child: btnName,
      ),
    );
  }
}
