import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saglamoglu_muhasebe/core/model/customer_model.dart';

class CustomerController {
  final String _basePath = "deliverycustomers";
  Future<List<CustomerModel>> getCustomers() async {
    var result = await FirebaseFirestore.instance
        .collection(_basePath)
        .orderBy("id", descending: true)
        .limit(50)
        .get();

    var res = List.generate(
        result.docs.length,
        (index) => CustomerModel(
              docId: result.docs.elementAt(index).id,
              id: result.docs.elementAt(index).data()['id'] ?? 0,
              name: result.docs.elementAt(index).data()['name'] ?? "",
              tcknvkn: result.docs.elementAt(index).data()['tcknvkn'] ?? "",
              agentName: result.docs.elementAt(index).data()['agentName'] ?? "",
              agentLastname:
                  result.docs.elementAt(index).data()['agentLastname'] ?? "",
              date: result.docs.elementAt(index).data()['date'] ?? "",
            ));

    return res;
  }

  Future<void> createCustomer(CustomerModel model) async {
    await FirebaseFirestore.instance.collection(_basePath).add({
      'id': model.id,
      'name': model.name,
      'tcknvkn': model.tcknvkn,
      'agentName': model.agentName,
      'agentLastname': model.agentLastname,
      'date': model.date,
      'telNo': model.telNo,
    });
  }

  Future<void> deleteCustomer(String? docId) async {
    await FirebaseFirestore.instance.collection(_basePath).doc(docId).delete();
  }

  Future<void> updateCustomer(
    String? docId,
    Map<String, dynamic> newData,
  ) async {
    await FirebaseFirestore.instance
        .collection(_basePath)
        .doc(docId)
        .update(newData);
  }

  CustomerModel customerStreamData(
      Map<String, dynamic> snapshot, String docId) {
    var data = CustomerModel(
      id: snapshot['id'] ?? 0,
      name: snapshot['name'] ?? "",
      tcknvkn: snapshot['tcknvkn'] ?? "",
      agentName: snapshot['agentName'] ?? "",
      agentLastname: snapshot['agentLastname'] ?? "",
      date: snapshot['date'] ?? "",
      telNo: snapshot['telNo'] ?? "",
      docId: docId,
    );

    return data;
  }
}
