import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saglamoglu_muhasebe/core/model/customer/customer_model.dart';

class CustomerController {
  static Future<List<CustomerModel>> getCustomers() async {
    List<CustomerModel> data = [];

    await FirebaseFirestore.instance
        .collection("deliverycustomers")
        .get()
        .then((value) {
      for (var element in value.docs) {
        data.add(CustomerModel(
          id: element['id'],
          name: element['name'],
          tcknvkn: element['tcknvkn'],
          agentName: element['agentName'],
          agentLastname: element['agentLastname'],
          date: element['date'],
        ));
      }
    });

    return data;
  }
}
