import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/model/authorized_model.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/authorized_controller.dart';
import 'package:saglamoglu_muhasebe/core/widget/custom_alert_card.dart';

class AuthorizedViewModel extends GetxController {
  static bool get isRegistered =>
      GetInstance().isRegistered<AuthorizedViewModel>();

  static AuthorizedViewModel get init => Get.put(AuthorizedViewModel());

  static AuthorizedViewModel get instance => Get.find<AuthorizedViewModel>();

  AuthorizedController get authorizedController => AuthorizedController();

  RxList<AuthorizedModel> allDataList = <AuthorizedModel>[].obs;

  Future<void> getAllData() async {
    var res = await authorizedController.getAllData();

    allDataList = res.obs;
    update();
  }

  String docType(String type) {
    if (type == "Talimat") {
      return "T";
    } else {
      return "V";
    }
  }

  Widget dateFormat(String? dateTime, BuildContext context) {
    String day = dateTime.toString().split("-")[2];
    String month = dateTime.toString().split("-")[1];

    return SizedBox(
      width: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            day,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(month),
        ],
      ),
    );
  }

  Query<Map<String, dynamic>> streamData = FirebaseFirestore.instance
      .collection("authorizedcustomers")
      .orderBy("customername");

  Stream<QuerySnapshot<Map<String, dynamic>>> dataStream() {
    return streamData.snapshots();
  }

  void deleteAuthorized(
    String? dataId,
    BuildContext context,
    String? customerName,
  ) {
    showDialog(
      context: context,
      builder: (_) => CustomAlertCard(
        title: customerName.toString(),
        message: "Yetki belgesini sil?",
        btnName: "Sil",
        actionFunc: () {
          authorizedController.deleteDocument(dataId);
          Navigator.pop(context);
        },
      ),
    );
  }
}
