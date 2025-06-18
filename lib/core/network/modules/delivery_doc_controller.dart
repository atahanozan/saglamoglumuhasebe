import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saglamoglu_muhasebe/core/model/doc_models.dart';

class DeliveryDocController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createDeliveryDoc(DeliveryDocModel model) async {
    await _firestore.collection("deliverydocs").add({
      "name": model.name,
      "tcknvkn": model.tcknvkn,
      "price": model.price,
      "company": model.company,
      "date": model.date,
      "agentName": model.agentName,
      "agentLastname": model.agentLastname,
      "currency": model.currency,
      "id": model.id,
      "statu": model.statu,
      "proccesstatu": model.proccesstatu,
    });
  }

  Future<void> deleteDoc(String? docId) async {
    await _firestore.collection("deliverydocs").doc(docId).delete();
  }

  Future<void> editDoc(Map<String, dynamic> newData, String? docId) async {
    await _firestore.collection("deliverydocs").doc(docId).update(newData);
  }

  Future<List<DeliveryDocModel>> getDeliverDocList(bool statu) async {
    var res = await _firestore
        .collection("deliverydocs")
        .where("statu", isEqualTo: statu)
        .limit(50)
        .orderBy("id", descending: true)
        .get();

    var result = List.generate(
      res.docs.length,
      (index) => DeliveryDocModel(
        name: res.docs[index].data()["name"] ?? "",
        tcknvkn: res.docs[index].data()["tcknvkn"] ?? "",
        price: res.docs[index].data()["price"] ?? "",
        company: res.docs[index].data()["company"] ?? "",
        date: res.docs[index].data()["date"] ?? "",
        agentLastname: res.docs[index].data()["agentLastname"] ?? "",
        agentName: res.docs[index].data()["agentName"] ?? "",
        currency: res.docs[index].data()["currency"] ?? "TL",
        id: res.docs[index].data()["id"] ?? 0,
        statu: res.docs[index].data()["statu"] ?? false,
        proccesstatu: res.docs[index].data()["proccesstatu"] ?? false,
      ),
    );

    return result;
  }

  DeliveryDocModel snapshotModel(Map<String, dynamic> snapshot, String docId) {
    var data = DeliveryDocModel(
      name: snapshot["name"] ?? "",
      tcknvkn: snapshot["tcknvkn"] ?? "",
      price: snapshot["price"] ?? "",
      company: snapshot["company"] ?? "",
      date: snapshot["date"] ?? "",
      agentName: snapshot["agentName"] ?? "",
      agentLastname: snapshot["agentLastname"] ?? "",
      currency: snapshot["currency"] ?? "",
      id: snapshot["id"] ?? 0,
      statu: snapshot["statu"] ?? false,
      proccesstatu: snapshot["proccesstatu"] ?? false,
      lastEditedDate: snapshot["lastEditedDate"].toString(),
    );

    return data;
  }
}
