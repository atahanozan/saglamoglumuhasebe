import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/model/authorized_model.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/authorized_controller.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';
import 'package:saglamoglu_muhasebe/core/widgets/custom_alert_card.dart';

class AuthorizedViewModel extends GetxController {
  static bool get isRegistered =>
      GetInstance().isRegistered<AuthorizedViewModel>();

  static AuthorizedViewModel get init => Get.put(AuthorizedViewModel());

  static AuthorizedViewModel get instance => Get.find<AuthorizedViewModel>();

  AuthorizedController get authorizedController => AuthorizedController();

  final TextEditingController searchController = TextEditingController();
  AppUser get appUser => AppUser.instance;

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

  Widget createdDate(BuildContext context, AuthorizedModel docModel) {
    var newDate = docModel.firstdate.toString();
    String day = newDate.toString().split("-")[2];
    String month = newDate.toString().split("-")[1];
    String year = newDate.toString().split("-")[0];

    return Text("$day.$month.$year");
  }

  Widget lastDate(BuildContext context, AuthorizedModel docModel) {
    var newDate = docModel.seconddate.toString();
    String day = newDate.toString().split("-")[2];
    String month = newDate.toString().split("-")[1];
    String year = newDate.toString().split("-")[0];

    return Text("$day.$month.$year");
  }

  RxBool isDataFiltered = false.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> dataStream() {
    switch (isDataFiltered.value) {
      case true:
        return FirebaseFirestore.instance
            .collection("authorizedcustomers")
            .where("customername",
                isGreaterThanOrEqualTo: searchController.text)
            .snapshots();
      case false:
        return FirebaseFirestore.instance
            .collection("authorizedcustomers")
            .orderBy("customername")
            .snapshots();
    }
  }

  void updateAuthorizedDataFilter() {
    isDataFiltered.value = true;
  }

  void cleanFilter() {
    isDataFiltered.value = false;
    searchController.clear();
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
