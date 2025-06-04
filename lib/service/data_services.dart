import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/helper/ui/uppercase_text_formatter.dart';

class DataServices {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String date = DateTime.now().toString().split(" ")[0];

  Future<void> addCustomer(
    String name,
    String tcknvkn,
    String agentName,
    String agentLastname,
  ) async {
    await _firestore.collection("deliverycustomers").add({
      "id": DateTime.now().millisecondsSinceEpoch,
      "name": name,
      "tcknvkn": tcknvkn,
      "date": date,
      "agentName": agentName,
      "agentLastname": agentLastname,
    });
  }

  Future<void> addDeliveryDoc(
    String name,
    String tcknvkn,
    String price,
    String company,
    String dateTime,
    String agentName,
    String agentLastname,
    String currency,
  ) async {
    await _firestore.collection("deliverydocs").add({
      "id": DateTime.now().millisecondsSinceEpoch,
      "name": name,
      "tcknvkn": tcknvkn,
      "date": dateTime,
      "price": price,
      "company": company,
      "statu": false,
      "proccesstatu": false,
      "agentName": agentName,
      "agentLastname": agentLastname,
      "currency": currency,
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

  Future<void> editCustomer(
      BuildContext context,
      TextEditingController tcknController,
      String tcknvkn,
      TextEditingController nameController,
      String name,
      String? docId) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Düzenle"),
        content: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          width: 450,
          child: Column(
            children: [
              const Divider(),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Expanded(flex: 1, child: Text("TCKN / VKN")),
                  const SizedBox(width: 15),
                  Expanded(
                      flex: 3,
                      child: TextField(
                        controller: tcknController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: tcknvkn),
                      ))
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Expanded(flex: 1, child: Text("İsim")),
                  const SizedBox(width: 15),
                  Expanded(
                      flex: 3,
                      child: TextField(
                        controller: nameController,
                        inputFormatters: [UppercaseTextFormatter()],
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: name),
                      ))
                ],
              )
            ],
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("İptal"),
          ),
          ElevatedButton(
              onPressed: () {
                _firestore.collection("deliverycustomers").doc(docId).update({
                  "name": nameController.text,
                  "tcknvkn": tcknController.text,
                });
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: const Text("Düzenle"))
        ],
      ),
    );
  }

  Future<void> editDeliveryDocStatu(BuildContext context, String name,
      bool statu, String? docId, String dateTime) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(name),
        content: statu
            ? Text("Gelmedi olarak işaretle?")
            : Text("Geldi olarak işaretle?"),
        actions: [
          ElevatedButton(
            onPressed: () async {
              if (statu) {
                await _firestore.collection("deliverydocs").doc(docId).update({
                  "statu": false,
                  "lastEditedDate": dateTime,
                });
                if (context.mounted) {
                  Navigator.pop(context);
                }
              } else {
                await _firestore.collection("deliverydocs").doc(docId).update({
                  "statu": true,
                  "lastEditedDate": dateTime,
                });
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
            child: Text("Tamam"),
          ),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("İptal"),
          ),
        ],
      ),
    );
  }

  Future<void> editDeliveryDoc(
    String? docId,
    Map<String, dynamic> newData,
  ) async {
    await _firestore.collection("deliverydocs").doc(docId).update(newData);
  }

  Future<void> addAuthorized(
    String firstdate,
    String seconddate,
    String customertckn,
    String customername,
    String authorizedtckn,
    String authorizedname,
    String doctype,
  ) async {
    await _firestore.collection("authorizedcustomers").add({
      "firstdate": firstdate,
      "seconddate": seconddate,
      "customertckn": customertckn,
      "customername": customername,
      "authorizedtckn": authorizedtckn,
      "authorizedname": authorizedname,
      "doctype": doctype,
    });
  }

  Future<void> deleteAuthorizedDoc(
    BuildContext context,
    String name,
    String? docId,
  ) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(name),
        content: Text("Dosyayı Sil ?"),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await _firestore
                  .collection("authorizedcustomers")
                  .doc(docId)
                  .delete();
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: Text("Tamam"),
          ),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            child: Text("İptal"),
          ),
        ],
      ),
    );
  }

  Stream customersOrderedById() {
    return _firestore
        .collection("deliverycustomers")
        .limit(50)
        .orderBy("id", descending: true)
        .snapshots();
  }

  Stream customersOrderedByName(String name) {
    return _firestore
        .collection("deliverycustomers")
        .limit(50)
        .where("name", isGreaterThanOrEqualTo: name)
        .snapshots();
  }

  Stream deliveryDocsAllFilters(
    String date,
    bool statu,
    String company1,
    String company2,
    String name,
    String price,
  ) {
    return _firestore
        .collection("deliverydocs")
        .limit(50)
        .where("statu", isEqualTo: statu)
        .where("date", isEqualTo: date)
        .where(Filter.or(
          Filter("company", isEqualTo: company1),
          Filter("company", isEqualTo: company2),
        ))
        .where(
          "name",
          isGreaterThanOrEqualTo: name,
        )
        .where(
          "price",
          isGreaterThanOrEqualTo: price,
        )
        .snapshots();
  }

  Stream deliveryDocsDateFilter(
    String date,
    bool statu,
    String company1,
    String company2,
  ) {
    return _firestore
        .collection("deliverydocs")
        .where("statu", isEqualTo: statu)
        .where("date", isEqualTo: date)
        .where(Filter.or(
          Filter("company", isEqualTo: company1),
          Filter("company", isEqualTo: company2),
        ))
        .orderBy("id", descending: true)
        .snapshots();
  }

  Stream deliveryDocsNameFilters(
    bool statu,
    String name,
  ) {
    return _firestore
        .collection("deliverydocs")
        .limit(50)
        .where("statu", isEqualTo: statu)
        .where(
          "name",
          isGreaterThanOrEqualTo: name,
        )
        .snapshots();
  }

  Stream deliveryDocsPriceFilters(
    bool statu,
    String price,
  ) {
    return _firestore
        .collection("deliverydocs")
        .limit(50)
        .where("statu", isEqualTo: statu)
        .where(
          "price",
          isGreaterThanOrEqualTo: price,
        )
        .snapshots();
  }

  Stream deliveryDocsCompanyFilters(
    bool statu,
    String company1,
    String company2,
  ) {
    return _firestore
        .collection("deliverydocs")
        .limit(50)
        .where("statu", isEqualTo: statu)
        .where(Filter.or(
          Filter("company", isEqualTo: company1),
          Filter("company", isEqualTo: company2),
        ))
        .orderBy("id", descending: true)
        .snapshots();
  }
}
