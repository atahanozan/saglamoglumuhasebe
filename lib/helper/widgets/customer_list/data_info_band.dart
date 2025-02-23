import 'package:flutter/material.dart';

class DataInfoBand extends StatelessWidget {
  const DataInfoBand({
    super.key,
    required this.customerName,
    required this.customerType,
    required this.customerId,
    required this.phone,
    required this.addDoc,
    required this.sendMessage,
    required this.donwload,
  });

  final String customerId;
  final String customerType;
  final String customerName;
  final String phone;
  final VoidCallback addDoc;
  final VoidCallback sendMessage;
  final VoidCallback donwload;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Text(customerId)),
          Expanded(child: Text(customerName)),
          Expanded(child: Text(customerType)),
          const SizedBox(width: 50),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Mesaj"),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            child: const Text("İndir"),
          ),
          const SizedBox(width: 10),
          ElevatedButton(
            onPressed: () {},
            child: const Text("Teslim Belg"),
          ),
        ],
      ),
    );
  }
}
