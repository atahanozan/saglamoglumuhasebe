import 'package:flutter/material.dart';

class NewPasswordStatuTexts extends StatelessWidget {
  const NewPasswordStatuTexts({
    super.key,
    required this.isContains,
    required this.content,
  });

  final bool isContains;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          isContains ? Icons.circle : Icons.circle_outlined,
          color: isContains ? Colors.green : Colors.grey,
        ),
        SizedBox(width: 12),
        Text(
          content,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: isContains ? Colors.green : Colors.grey,
              ),
        )
      ],
    );
  }
}
