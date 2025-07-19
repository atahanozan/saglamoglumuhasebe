import 'package:flutter/material.dart';

class CustomerGridHeaders extends StatelessWidget {
  const CustomerGridHeaders({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? pageStyle =
        Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: 25),
        Expanded(
          child: Text(
            "Tarih",
            style: pageStyle,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "TCKN / VKN",
            style: pageStyle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Müşteri Adı",
              style: pageStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              "İlgili Adı",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        )),
        const SizedBox(width: 8),
        Expanded(
            child: Text(
          "Tel No",
          style: pageStyle,
        )),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            "İşlemler",
            style: pageStyle,
          ),
        ),
      ],
    );
  }
}
