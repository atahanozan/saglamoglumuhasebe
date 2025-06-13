import 'package:flutter/material.dart';

class DatePickerWidget extends StatelessWidget {
  const DatePickerWidget({
    super.key,
    required this.selectDate,
    required this.btnDate,
  });

  final VoidCallback selectDate;
  final String btnDate;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selectDate,
      child: Container(
        height: 45,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(btnDate),
            SizedBox(width: 12),
            Icon(Icons.calendar_month_rounded),
          ],
        ),
      ),
    );
  }
}
