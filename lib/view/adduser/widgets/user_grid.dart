import 'package:flutter/material.dart';

class UserGrid extends StatelessWidget {
  const UserGrid({
    super.key,
    required this.statuChild,
    required this.classChild,
    required this.nameChild,
    required this.actionChild,
    required this.emailChild,
    this.gridColor,
    this.borderColor,
  });

  final Widget statuChild;
  final Widget classChild;
  final Widget nameChild;
  final Widget emailChild;
  final Widget actionChild;
  final Color? gridColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          color: gridColor,
          border: Border(
            bottom: BorderSide(
              color: borderColor ?? Colors.transparent,
            ),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: statuChild),
          Expanded(flex: 1, child: classChild),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  nameChild,
                  emailChild,
                ],
              )),
          Expanded(child: actionChild),
        ],
      ),
    );
  }
}
