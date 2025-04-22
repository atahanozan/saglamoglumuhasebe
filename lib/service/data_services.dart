import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DataServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String date = DateTime.now().toString().split(" ")[0];

  Future<void> addCustomer(
    String name,
    String tcknvkn,
  ) async {
    await _firestore.collection("deliverycustomers").add({
      "id": DateTime.now().millisecondsSinceEpoch,
      "name": name,
      "tcknvkn": tcknvkn,
      "date": date,
    });
  }

  Future<void> addDeliveryDoc(
    String name,
    String tcknvkn,
    String price,
    String company,
    String dateTime,
  ) async {
    await _firestore.collection("deliverydocs").add({
      "id": DateTime.now().millisecondsSinceEpoch,
      "name": name,
      "tcknvkn": tcknvkn,
      "date": dateTime,
      "price": price,
      "company": company,
      "statu": false,
    });
  }

  Future<void> deleteCustomer(
    String id,
    String name,
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(name),
        content: Text("Müşteriyi sil ?"),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await _firestore.collection("deliverycustomers").doc(id).delete();
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: Text("Sil"),
          ),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("İptal"),
          ),
        ],
      ),
    );
  }

  Future<void> deleteDeliveryDoc(
    String id,
    String name,
    BuildContext context,
  ) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(name),
        content: Text("Teslim dosyasını sil ?"),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await _firestore.collection("deliverydocs").doc(id).delete();
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: Text("Sil"),
          ),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("İptal"),
          ),
        ],
      ),
    );
  }
}
