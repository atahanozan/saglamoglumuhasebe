import 'package:flutter/material.dart';

class AddDeliveryDoc extends StatelessWidget {
  const AddDeliveryDoc({
    super.key,
    required this.companyName,
    required this.name,
    required this.price,
    required this.tckn,
    required this.date,
    required this.datePick,
  });

  final String name;
  final String tckn;
  final String companyName;
  final String price;
  final String date;
  final VoidCallback datePick;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey.shade400,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Text("Tarih"),
              ),
              Expanded(
                  child: TextButton(
                onPressed: datePick,
                child: Text(date),
              )),
            ],
          )
        ],
      ),
    );
  }
}
