import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/model/tesdoc_model.dart';

class TesdocController {
  final String _basePath = "tesdoccustomers";

  Future<bool> setData(TesdocModel data) async {
    try {
      await FirebaseFirestore.instance
          .collection(_basePath)
          .doc(data.customerTckn)
          .set(data.toJson());
      await FirebaseFirestore.instance
          .collection('deliverycustomers')
          .doc(data.customerUid)
          .update({
        "tesStatu": "1",
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<void> updateData(
      Map<String, dynamic> newData, String? docId, BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Müşteri durumu güncellenecek onaylıyor musunuz?"),
              actions: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("İptal"),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection(_basePath)
                          .doc(docId)
                          .update(newData);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Evet"))
              ],
            ));
  }

  Future<void> deleteData(TesdocModel data, BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
            "${data.customerName} isimli müşteri için açılan talep silinecektir."),
        actions: [
          OutlinedButton(
              onPressed: () => Navigator.pop(context), child: Text("İptal")),
          ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection(_basePath)
                    .doc(data.customerTckn)
                    .delete();
                await FirebaseFirestore.instance
                    .collection("deliverycustomers")
                    .doc(data.customerUid)
                    .update({"tesStatu": "0"});
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text("Sil")),
        ],
      ),
    );
  }

  Future<int?> getDataCount(
    String dataStatuName,
    String dataStatu,
    DateTime startsAt,
    DateTime endsAt,
  ) async {
    var res = await FirebaseFirestore.instance
        .collection("tesdoccustomers")
        .where(dataStatuName, isEqualTo: dataStatu)
        .where("dateTime", isGreaterThan: Timestamp.fromDate(startsAt))
        .where("dateTime", isLessThan: Timestamp.fromDate(endsAt))
        .count()
        .get();

    return res.count;
  }

  Stream tesDocStream(
    int filterStatu,
    String filterName,
    String? filterValue,
  ) {
    switch (filterStatu) {
      case 0:
        var response = FirebaseFirestore.instance
            .collection("tesdoccustomers")
            .where("tesStatu", isNotEqualTo: "3")
            .orderBy("id", descending: true)
            .limit(20)
            .snapshots();

        return response;
      case 1:
        var response = FirebaseFirestore.instance
            .collection("tesdoccustomers")
            .where(filterName, isEqualTo: filterValue)
            .limit(20)
            .snapshots();

        return response;
      case 2:
        var response = FirebaseFirestore.instance
            .collection("tesdoccustomers")
            .where(filterName, isGreaterThanOrEqualTo: filterValue)
            .limit(20)
            .snapshots();

        return response;

      default:
        var response = FirebaseFirestore.instance
            .collection("tesdoccustomers")
            .where("tesStatu", isNotEqualTo: "3")
            .orderBy("id", descending: true)
            .limit(20)
            .snapshots();

        return response;
    }
  }
}
