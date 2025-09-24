import 'package:flutter/material.dart';

class AuthorizedGridSkeleton extends StatelessWidget {
  const AuthorizedGridSkeleton({
    super.key,
    required this.style,
    required this.firstDate,
    required this.secondDate,
    required this.customer,
    required this.authorized,
    required this.apps,
  });

  final Widget style;
  final Widget firstDate;
  final Widget secondDate;
  final Widget customer;
  final Widget authorized;
  final Widget apps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: style,
          ),
          SizedBox(
            width: 200,
            child: firstDate,
          ),
          SizedBox(
            width: 200,
            child: secondDate,
          ),
          SizedBox(
            width: 450,
            child: customer,
          ),
          SizedBox(
            width: 300,
            child: authorized,
          ),
          SizedBox(
            width: 120,
            child: apps,
          ),
        ],
      ),
    );
  }
}
