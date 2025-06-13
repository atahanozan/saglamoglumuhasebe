import 'package:flutter/material.dart';

class Headers extends StatelessWidget {
  const Headers({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? pageStyle =
        Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            );
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(width: 26),
        Text(
          "Tarih",
          style: pageStyle,
        ),
        const SizedBox(width: 12),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Müşteri",
              style: pageStyle,
              textAlign: TextAlign.left,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "ilgilenen",
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        )),
        const SizedBox(width: 5),
        Text(
          "Firma",
          textAlign: TextAlign.left,
          style: pageStyle,
        ),
        const SizedBox(width: 5),
        Expanded(
            child: Text(
          "Tutar",
          textAlign: TextAlign.right,
          style: pageStyle,
        )),
        const SizedBox(width: 30),
        Text(
          "İşlemler",
          style: pageStyle,
        ),
        const SizedBox(width: 26),
      ],
    );
  }
}
