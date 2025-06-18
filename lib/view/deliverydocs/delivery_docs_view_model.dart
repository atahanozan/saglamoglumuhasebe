import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/enums/delivery_doc_stream_filter_enums.dart';
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
  final TextEditingController priceController = TextEditingController();

  DeliveryDocController get deliveryController => DeliveryDocController();

  RxList<DeliveryDocModel> finalWaitingData = <DeliveryDocModel>[].obs;
  RxList<DeliveryDocModel> finalCompleteData = <DeliveryDocModel>[].obs;

  String get timeStamp => DateTime.now().toString().split(" ")[0];

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
    if (dateTime == "" || dateTime == null) {
      return Text("");
    } else {
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
  }

  Rx<DeliveryDocStreamFilterEnums> filterTypeWaiting =
      DeliveryDocStreamFilterEnums.clean.obs;
  Rx<DeliveryDocStreamFilterEnums> filterTypeCompleted =
      DeliveryDocStreamFilterEnums.clean.obs;
  RxString companyFilterSaglam = "Sağlam".obs;
  RxString companyFilterElmina = "Elmina".obs;
  RxString companyFilterGeneral = "".obs;
  RxString seacrhFilterContent = "".obs;
  RxString priceFilterContent = "".obs;
  RxString dateFilter = DateTime.now().toString().split(" ")[0].obs;

  Stream<QuerySnapshot<Map<String, dynamic>>> deliverCompletedStream(
    bool deliveryStatu,
    DeliveryDocStreamFilterEnums filterEnum,
  ) {
    var documentData = FirebaseFirestore.instance
        .collection("deliverydocs")
        .where("statu", isEqualTo: deliveryStatu);
    switch (filterEnum) {
      case DeliveryDocStreamFilterEnums.search:
        return documentData
            .where("name", isGreaterThanOrEqualTo: seacrhFilterContent.value)
            .limit(10)
            .snapshots();
      case DeliveryDocStreamFilterEnums.date:
        return documentData
            .where("date", isEqualTo: dateFilter.value)
            .where(
              Filter.or(
                Filter("company", isEqualTo: companyFilterSaglam.value),
                Filter("company", isEqualTo: companyFilterElmina.value),
              ),
            )
            .snapshots();
      case DeliveryDocStreamFilterEnums.clean:
        return documentData
            .orderBy("id", descending: true)
            .where(
              Filter.or(
                Filter("company", isEqualTo: companyFilterSaglam.value),
                Filter("company", isEqualTo: companyFilterElmina.value),
              ),
            )
            .limit(20)
            .snapshots();

      case DeliveryDocStreamFilterEnums.price:
        return documentData
            .where("price", isGreaterThanOrEqualTo: priceFilterContent.value)
            .limit(10)
            .snapshots();
    }
  }

  void updateWaitingDataFilterWithSearch(String searchName) {
    filterTypeWaiting.value = DeliveryDocStreamFilterEnums.search;
    seacrhFilterContent.value = searchName;
  }

  void updateCompleteDataFilterWithSearch(String searchName) {
    filterTypeCompleted.value = DeliveryDocStreamFilterEnums.search;
    seacrhFilterContent.value = searchName;
  }

  void updateDataFilterWithPrice(String priceCont) {
    filterTypeCompleted.value = DeliveryDocStreamFilterEnums.price;
    filterTypeWaiting.value = DeliveryDocStreamFilterEnums.price;
    priceFilterContent.value = priceCont;
  }

  void cleanDataFilter() {
    filterTypeWaiting.value = DeliveryDocStreamFilterEnums.clean;
    filterTypeCompleted.value = DeliveryDocStreamFilterEnums.clean;
    searchController.clear();
    priceController.clear();
    companyFilterSaglam.value = "Sağlam";
    companyFilterElmina.value = "Elmina";
    companyFilterGeneral.value = "";
    dateFilter.value = DateTime.now().toString().split(" ")[0];
    seacrhFilterContent.value = "";
    priceFilterContent.value = "";
    update();
  }

  Future<void> updateDateFilter(
    BuildContext context,
  ) async {
    var newDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2040, 1, 1),
      initialDate: DateTime.parse(dateFilter.value),
    );

    dateFilter.value = newDate.toString().split(" ")[0];

    filterTypeCompleted.value = DeliveryDocStreamFilterEnums.date;
    filterTypeWaiting.value = DeliveryDocStreamFilterEnums.date;

    update();
  }

  void updateCompanyFilter(String companyName) {
    companyFilterSaglam.value = companyName;
    companyFilterElmina.value = companyName;
    companyFilterGeneral.value = companyName;
    update();
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
      String? docId, bool newStatu, BuildContext context, String dateTime) {
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
              "lastEditedDate": dateTime,
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

  String editedDate(String? timeStamp) {
    if (timeStamp == null) {
      return "";
    } else if (timeStamp.startsWith("Time")) {
      var res = int.parse(timeStamp.split("=")[1].split(",")[0]);
      return DateTime.fromMillisecondsSinceEpoch(res * 1000)
          .toString()
          .split(" ")[0];
    } else if (timeStamp == "null") {
      return "";
    } else {
      return timeStamp.toString();
    }
  }
}
