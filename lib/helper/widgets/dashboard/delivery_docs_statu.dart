import 'package:flutter/material.dart';

class DeliveryDocsStatu extends StatelessWidget {
  const DeliveryDocsStatu({
    super.key,
    required this.statuFalse,
    required this.statuTrue,
    required this.total,
  });

  final int statuTrue;
  final int statuFalse;
  final int total;

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          "Teslim Dosya Durumu",
          style: pageStyle.headlineSmall,
        ),
        Divider(),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Geldi"),
                  Text(
                    "$statuTrue",
                    style: pageStyle.headlineSmall
                        ?.copyWith(color: Colors.green.shade800),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Bekleniyor"),
                  Text(
                    "$statuFalse",
                    style: pageStyle.headlineSmall
                        ?.copyWith(color: Colors.red.shade800),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(),
        Text("$total", style: pageStyle.headlineMedium),
      ],
    );
  }
}
