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
            customerStatu:
                result.docs.elementAt(index).data()['customerStatu'] ?? "",
            agents: result.docs.elementAt(index).data()['agents'] ?? [],
            tesStatu: result.docs.elementAt(index).data()['tesStatu'] ?? "0"));

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
      'frontId': model.frontId,
      'customerStatu': model.customerStatu,
      'agents': model.agents,
      'tesStatu': model.tesStatu,
    });
  }

  Future<void> deleteCustomer(String? docId, List<dynamic>? agents) async {
    await FirebaseFirestore.instance.collection(_basePath).doc(docId).update({
      "customerStatu": "D",
      "agents": agents,
    });
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
      customerStatu: snapshot['customerStatu'] ?? "",
      agents: snapshot['agents'] ?? [],
      tesStatu: snapshot['tesStatu'] ?? "0",
      docId: docId,
    );

    return data;
  }
}
