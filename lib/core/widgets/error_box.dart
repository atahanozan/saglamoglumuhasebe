import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  const ErrorBox({
    super.key,
    required this.boxVisibility,
    required this.content,
    required this.closeBox,
  });

  final bool boxVisibility;
  final String content;
  final VoidCallback closeBox;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: boxVisibility,
      child: InkWell(
        onTap: closeBox,
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(18),
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "Hata",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Spacer(),
                  Icon(Icons.close),
                ],
              ),
              SizedBox(height: 12),
              Text(content),
            ],
          ),
        ),
      ),
    );
  }
}
