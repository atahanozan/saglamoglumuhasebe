import 'package:flutter/material.dart';

class GridSkeleton extends StatelessWidget {
  const GridSkeleton({
    super.key,
    required this.apps,
    required this.createdDate,
    required this.customer,
    required this.firstTransaction,
    required this.lasUpdate,
    required this.lastUser,
    required this.price,
    required this.secondTransaction,
    this.border,
  });

  final Widget createdDate;
  final Widget lasUpdate;
  final Widget customer;
  final Widget lastUser;
  final Widget price;
  final Widget firstTransaction;
  final Widget secondTransaction;
  final Widget apps;
  final BoxBorder? border;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(seconds: 1),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      decoration: BoxDecoration(
        border: border,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 120, alignment: Alignment.centerLeft, child: createdDate),
          SizedBox(width: 12),
          Container(
              width: 120, alignment: Alignment.centerLeft, child: lasUpdate),
          SizedBox(width: 12),
          Expanded(flex: 2, child: customer),
          SizedBox(width: 12),
          Container(
              width: 250, alignment: Alignment.centerLeft, child: lastUser),
          SizedBox(width: 12),
          Expanded(child: price),
          SizedBox(width: 12),
          Container(
              width: 200,
              alignment: Alignment.centerLeft,
              child: firstTransaction),
          SizedBox(width: 12),
          Container(
              width: 250,
              alignment: Alignment.centerLeft,
              child: secondTransaction),
          SizedBox(width: 12),
          Container(width: 100, alignment: Alignment.centerLeft, child: apps),
        ],
      ),
    );
  }
}
