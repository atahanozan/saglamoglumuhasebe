import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
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

  Future<bool> updateData(Map<String, dynamic> newData, String? docId) async {
    try {
      await FirebaseFirestore.instance
          .collection(_basePath)
          .doc(docId)
          .update(newData);
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> deleteData(TesdocModel data) async {
    try {
      await FirebaseFirestore.instance
          .collection(_basePath)
          .doc(data.customerTckn)
          .delete();
      await FirebaseFirestore.instance
          .collection("deliverycustomers")
          .doc(data.customerUid)
          .update({"tesStatu": "0"});
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }
}
