import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/model/auth_model.dart';
import 'package:saglamoglu_muhasebe/core/model/doc_models.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/delivery_doc_controller.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';
import 'package:saglamoglu_muhasebe/core/widget/custom_alert_card.dart';
import 'package:saglamoglu_muhasebe/core/widget/pdf/pdf_controller.dart';

class DeliveryDocsViewModel extends GetxController {
  static bool get isRegistered =>
      GetInstance().isRegistered<DeliveryDocsViewModel>();

  static DeliveryDocsViewModel get init => Get.put(DeliveryDocsViewModel());

  static DeliveryDocsViewModel get instance =>
      Get.find<DeliveryDocsViewModel>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController searchController = TextEditingController();

  DeliveryDocController get deliveryController => DeliveryDocController();

  RxList<DeliveryDocModel> finalWaitingData = <DeliveryDocModel>[].obs;
  RxList<DeliveryDocModel> finalCompleteData = <DeliveryDocModel>[].obs;

  DateTime get timeStamp => DateTime.now();

  AppUser get appUser => AppUser.init;

  Rx<AuthModel> userInfo = AuthModel().obs;

  void getUserName() async {
    var name = await appUser.getUserData();

    userInfo = name.obs;
    update();
  }

  Future<void> getAllData() async {
    var res = await deliveryController.getDeliverDocList(false);

    finalWaitingData = res.obs;
    update();
  }

  Future<void> getAllCompleteData() async {
    var result = await deliveryController.getDeliverDocList(true);

    finalCompleteData = result.obs;
    update();
  }

  MaterialColor headerColor(bool? proccessStatu, bool? statu) {
    switch (proccessStatu) {
      case false:
        return statu == true ? Colors.green : Colors.red;
      case true:
        return Colors.grey;
      default:
        return statu == true ? Colors.green : Colors.red;
    }
  }

  bool btnVisibility(bool? visible) {
    switch (visible) {
      case true:
        return false;
      case false:
        return true;
      default:
        return false;
    }
  }

  Widget dateFormat(String? dateTime, BuildContext context) {
    String day = dateTime.toString().split("-")[2];
    String month = dateTime.toString().split("-")[1];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          day,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(month),
      ],
    );
  }

  RxBool isWaitingDataFiltered = false.obs;
  RxBool isCompletedDataFiltered = false.obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> deliverCompletedStream(
    bool deliveryStatu,
    bool isFilteredData,
  ) {
    switch (isFilteredData) {
      case true:
        return FirebaseFirestore.instance
            .collection("deliverydocs")
            .limit(20)
            .where("statu", isEqualTo: deliveryStatu)
            .where("name", isGreaterThanOrEqualTo: searchController.text)
            .snapshots();
      case false:
        return FirebaseFirestore.instance
            .collection("deliverydocs")
            .where("statu", isEqualTo: deliveryStatu)
            .orderBy("id", descending: true)
            .limit(50)
            .snapshots();
    }
  }

  void updateWaitingDataFilterWithSearch() {
    isWaitingDataFiltered.value = true;
  }

  void updateCompleteDataFilterWithSearch() {
    isCompletedDataFiltered.value = true;
  }

  void cleanWaitingDataFilter() {
    isWaitingDataFiltered.value = false;
    searchController.clear();
  }

  void cleanCompleteDataFilter() {
    isCompletedDataFiltered.value = false;
    searchController.clear();
  }

  void deleteDeliveryDoc(
    String? docId,
    BuildContext context,
    String name,
    String price,
  ) {
    showDialog(
      context: context,
      builder: (_) => CustomAlertCard(
        title: name,
        message: "$price tutarındaki teslim belgesi silinecektir.",
        btnName: "Sil",
        actionFunc: () {
          deliveryController.deleteDoc(docId);
          Navigator.pop(context);
        },
      ),
    );
  }

  void printDeliveryDoc(
    String name,
    String tckn,
    String companyName,
    String price,
    String currency,
    BuildContext context,
    DateTime date,
  ) {
    PdfController().customerDeliveryDoc(
      name,
      tckn,
      companyName,
      price,
      currency,
      context,
      date,
      true,
    );
  }

  void saveDeliveryDoc(
    String name,
    String tckn,
    String companyName,
    String price,
    String currency,
    BuildContext context,
    DateTime date,
  ) {
    PdfController().customerDeliveryDoc(
      name,
      tckn,
      companyName,
      price,
      currency,
      context,
      date,
      false,
    );
  }

  void updateDocStatu(
    String? docId,
    bool newStatu,
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (_) => CustomAlertCard(
        title: "Statu değiştir",
        message: "Teslim belgesinin durumu değiştirilecektir",
        btnName: "Değiştir",
        actionFunc: () {
          deliveryController.editDoc(
            {
              "statu": newStatu,
              "lastEditedDate": timeStamp,
            },
            docId,
          );
          Navigator.pop(context);
        },
      ),
    );
  }

  void updateDocProccessStatu(
    String? docId,
    bool newStatu,
  ) {
    deliveryController.editDoc(
      {
        "proccesstatu": newStatu,
      },
      docId,
    );
  }
}
