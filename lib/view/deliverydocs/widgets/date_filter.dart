import 'package:flutter/material.dart';

class DateFilter extends StatelessWidget {
  const DateFilter({
    super.key,
    required this.datePickFunc,
    required this.btnDate,
  });

  final VoidCallback datePickFunc;
  final String btnDate;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: datePickFunc,
      child: Text(btnDate),
    );
  }
}
