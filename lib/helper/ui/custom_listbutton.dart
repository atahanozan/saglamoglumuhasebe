import 'package:flutter/material.dart';

class CustomListbutton extends StatelessWidget {
  const CustomListbutton({
    super.key,
    required this.btnName,
    required this.btnFunc,
  });

  final String btnName;
  final VoidCallback btnFunc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: btnFunc,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: 5),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.black12,
        ),
        child: Text(
          btnName,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
