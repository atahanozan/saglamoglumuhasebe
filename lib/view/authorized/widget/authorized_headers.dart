import 'package:flutter/material.dart';

class AuthorizedHeaders extends StatelessWidget {
  const AuthorizedHeaders({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? pageStyle =
        Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            );
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          color: Colors.grey.shade200,
        )),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            "Tür",
            style: pageStyle,
          ),
          const SizedBox(width: 18),
          Text(
            "Tarih",
            style: pageStyle,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Text("Yetkilendiren", style: pageStyle),
          ),
          Expanded(
            child: Text("Yetkili", style: pageStyle),
          ),
          Text("İşlemler", style: pageStyle),
        ],
      ),
    );
  }
}
