import 'package:flutter/material.dart';

class CustomAlertCard extends StatelessWidget {
  const CustomAlertCard({
    super.key,
    required this.title,
    required this.message,
    required this.btnName,
    required this.actionFunc,
  });

  final String title;
  final String message;
  final String btnName;
  final VoidCallback actionFunc;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: Text("İptal"),
        ),
        ElevatedButton(
          onPressed: actionFunc,
          child: Text(btnName),
        ),
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      insetPadding: EdgeInsets.all(18),
      actionsOverflowDirection: VerticalDirection.down,
    );
  }
}
