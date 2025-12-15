import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/enums/delivery_doc_stream_filter_enums.dart';
import 'package:saglamoglu_muhasebe/core/model/auth_model.dart';
import 'package:saglamoglu_muhasebe/core/model/doc_models.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/delivery_doc_controller.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';
import 'package:saglamoglu_muhasebe/core/widgets/custom_alert_card.dart';
import 'package:saglamoglu_muhasebe/core/widgets/pdf/pdf_controller.dart';

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

  String createdDate(DeliveryDocModel docModel, BuildContext context) {
    if (docModel.date == "" || docModel.date == null) {
      return "";
    } else {
      String day = docModel.date.toString().split("-")[2];
      String month = docModel.date.toString().split("-")[1];
      String year = docModel.date.toString().split("-")[0];

      return "$day.$month.$year";
    }
  }

  String lastUpdateDate(DeliveryDocModel docModel, BuildContext context) {
    var newAgentList = docModel.agents;
    if (newAgentList != null) {
      if (newAgentList.isEmpty) {
        String day = docModel.date.toString().split("-")[2];
        String month = docModel.date.toString().split("-")[1];
        String year = docModel.date.toString().split("-")[0];

        return "$day.$month.$year";
      } else {
        var lastUpdate =
            newAgentList.last.toString().split("&")[0].split(" ")[0];
        String day = lastUpdate.split("-")[2];
        String month = lastUpdate.split("-")[1];
        String year = lastUpdate.split("-")[0];

        return "$day.$month.$year";
      }
    } else {
      String day = docModel.date.toString().split("-")[2];
      String month = docModel.date.toString().split("-")[1];
      String year = docModel.date.toString().split("-")[0];

      return "$day.$month.$year";
    }
  }

  Rx<DeliveryDocStreamFilterEnums> filterType =
      DeliveryDocStreamFilterEnums.clean.obs;
  RxString companyFilter = "".obs;
  RxString seacrhFilterContent = "".obs;
  RxString priceFilterContent = "".obs;
  RxBool isDated = false.obs;
  RxString dateFilter = DateTime.now().toString().split(" ")[0].obs;

  Rx<Query<Map<String, dynamic>>> deliveryStream = FirebaseFirestore.instance
      .collection("deliverydocs")
      .where("statu", isEqualTo: false)
      .orderBy("id", descending: true)
      .obs;

  Future<void> setDeliveryDocStream({
    String newCompanyFilter = "",
    String newSearchFilter = "",
    String newPriceFilter = "",
    bool newIsDated = false,
    String newDateFilter = "",
    DeliveryDocStreamFilterEnums filterEnum =
        DeliveryDocStreamFilterEnums.clean,
  }) async {
    var documentData = FirebaseFirestore.instance
        .collection("deliverydocs")
        .where("statu", isEqualTo: false);

    if (newIsDated == true && newCompanyFilter.isNotEmpty) {
      var res = documentData
          .where("company", isEqualTo: newCompanyFilter)
          .where("date", isEqualTo: newDateFilter);

      if (filterEnum == DeliveryDocStreamFilterEnums.search) {
        var data =
            await res.where("name", isEqualTo: newSearchFilter).count().get();

        deliveryStream.value = data.count! > 0
            ? res.where("name", isEqualTo: newSearchFilter)
            : res.where("name", isGreaterThanOrEqualTo: newSearchFilter);
        update();
      } else if (filterEnum == DeliveryDocStreamFilterEnums.price) {
        deliveryStream.value =
            res.where("price", isGreaterThanOrEqualTo: newPriceFilter);
        update();
      } else {
        deliveryStream.value = res;
        update();
      }
    } else if (newIsDated == true && newCompanyFilter.isEmpty) {
      var res = documentData.where("date", isEqualTo: newDateFilter);

      if (filterEnum == DeliveryDocStreamFilterEnums.search) {
        var data =
            await res.where("name", isEqualTo: newSearchFilter).count().get();

        deliveryStream.value = data.count! > 0
            ? res.where("name", isEqualTo: newSearchFilter)
            : res.where("name", isGreaterThanOrEqualTo: newSearchFilter);
        update();
      } else if (filterEnum == DeliveryDocStreamFilterEnums.price) {
        deliveryStream.value =
            res.where("price", isGreaterThanOrEqualTo: newPriceFilter);
        update();
      } else {
        deliveryStream.value = res;
        update();
      }
    } else if (newIsDated == false && newCompanyFilter.isNotEmpty) {
      var res = documentData.where("company", isEqualTo: newCompanyFilter);

      if (filterEnum == DeliveryDocStreamFilterEnums.search) {
        var data =
            await res.where("name", isEqualTo: newSearchFilter).count().get();

        deliveryStream.value = data.count! > 0
            ? res.where("name", isEqualTo: newSearchFilter)
            : res.where("name", isGreaterThanOrEqualTo: newSearchFilter);
        update();
      } else if (filterEnum == DeliveryDocStreamFilterEnums.price) {
        deliveryStream.value =
            res.where("price", isGreaterThanOrEqualTo: newPriceFilter);
        update();
      } else {
        deliveryStream.value = res;
        update();
      }
    } else {
      if (filterEnum == DeliveryDocStreamFilterEnums.search) {
        var data = await documentData
            .where("name", isEqualTo: newSearchFilter)
            .count()
            .get();

        deliveryStream.value = data.count! > 0
            ? documentData.where("name", isEqualTo: newSearchFilter)
            : documentData.where("name",
                isGreaterThanOrEqualTo: newSearchFilter);
        update();
      } else if (filterEnum == DeliveryDocStreamFilterEnums.price) {
        deliveryStream.value =
            documentData.where("price", isGreaterThanOrEqualTo: newPriceFilter);
        update();
      } else {
        deliveryStream.value = documentData;
        update();
      }
      update();
    }
    update();
  }

  Future<List<DeliveryDocModel>> deliverDocsFilteryExcelFilteredData(
      Query<Map<String, dynamic>> queryData) async {
    var res = await queryData.get();

    var result = res.docs
        .map((docsData) => DeliveryDocModel.fromDocument(docsData.data()))
        .toList();

    return result;
  }

  void cleanDataFilter() {
    filterType.value = DeliveryDocStreamFilterEnums.clean;
    searchController.clear();
    priceController.clear();
    companyFilter.value = "";

    dateFilter.value = DateTime.now().toString().split(" ")[0];
    seacrhFilterContent.value = "";
    priceFilterContent.value = "";
    isDated.value = false;
    deliveryStream.value = FirebaseFirestore.instance
        .collection("deliverydocs")
        .where("statu", isEqualTo: false)
        .orderBy("id", descending: true);
    update();
  }

  Future<void> updateDataFilterWithDate(
    BuildContext context,
  ) async {
    var newDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2040, 1, 1),
      initialDate: DateTime.parse(dateFilter.value),
    );

    dateFilter.value = newDate.toString().split(" ")[0];

    filterType.value = DeliveryDocStreamFilterEnums.date;
    isDated.value = true;
    setDeliveryDocStream(
        newIsDated: true,
        newDateFilter: newDate.toString().split(" ")[0],
        newCompanyFilter: companyFilter.value);

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

  Future<void> printAllDocs(
      Query<Map<String, dynamic>> queryData, BuildContext context) async {
    var res = await queryData.get();

    var result = res.docs
        .map(
          (element) => DeliveryDocModel(
            name: element['name'] ?? "",
            tcknvkn: element['tcknvkn'] ?? "",
            price: element['price'] ?? "",
            company: element['company'] ?? "",
            date: element['date'] ?? "",
            currency: element['currency'] ?? "",
            id: element['id'] ?? 0,
            statu: element['statu'] ?? false,
            proccesstatu: element['proccesstatu'] ?? false,
          ),
        )
        .toList();

    if (result.length < 10) {
      for (var i = 0; i < result.length; i++) {
        var data = result.elementAt(i);
        if (context.mounted) {
          PdfController().customerDeliveryDoc(
              data.name ?? "",
              data.tcknvkn ?? "",
              data.company ?? "",
              data.price ?? "",
              data.currency ?? "",
              context,
              DateTime.parse(data.date ?? "2025-01-01"),
              false,
              isDirectPrinting: true,
              printerName: "Canon GX7000 series");
        }
      }
    }
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

  void updateDocStatu(String? docId, bool newStatu, BuildContext context,
      String dateTime, DeliveryDocModel docModel) {
    var newAgentList = docModel.agents;
    if (newAgentList != null) {
      newAgentList.add(
          "${DateTime.now()}&${appUser.thisUser.value.name} ${appUser.thisUser.value.lastName}&İmzalı Döküman Teslim Alındı");
      Future.delayed(const Duration(milliseconds: 200), () {
        if (context.mounted) {
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
                    "newDocStatu": "Döküman Teslim Alındı",
                    "agents": newAgentList,
                  },
                  docId,
                );
                Navigator.pop(context);
              },
            ),
          );
        }
      });
    } else {
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
                "newDocStatu": "Döküman Teslim Alındı",
                "agents": [
                  "${DateTime.now()}&${appUser.thisUser.value.name} ${appUser.thisUser.value.lastName}"
                ],
              },
              docId,
            );
            Navigator.pop(context);
          },
        ),
      );
    }
  }

  void updateDocProccessStatu(
    String? docId,
    bool newStatu,
    DeliveryDocModel docModel,
    String newProccessStatu,
  ) {
    var newAgentList = docModel.agents;
    if (newAgentList != null) {
      newAgentList.add(
          "${DateTime.now()}&${appUser.thisUser.value.name} ${appUser.thisUser.value.lastName}&$newProccessStatu");
      Future.delayed(const Duration(milliseconds: 200), () {
        deliveryController.editDoc(
          {
            "proccesstatu": newStatu,
            "newProccessStatu": newProccessStatu,
            "agents": newAgentList,
          },
          docId,
        );
      });
    } else {
      deliveryController.editDoc(
        {
          "proccesstatu": newStatu,
          "newProccessStatu": newProccessStatu,
          "agents": [
            "${DateTime.now()}&${appUser.thisUser.value.name} ${appUser.thisUser.value.lastName}"
          ],
        },
        docId,
      );
    }
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

  RxBool filterTabStatu = false.obs;

  void changeFilterTabStatu() {
    filterTabStatu.value = !filterTabStatu.value;
  }

  String agentName(DeliveryDocModel docModel) {
    if (docModel.agents != null) {
      if (docModel.agents!.isNotEmpty) {
        return docModel.agents?.last.toString().split("&")[1] ?? "";
      } else {
        return "${docModel.agentName} ${docModel.agentLastname}";
      }
    } else {
      return "${docModel.agentName} ${docModel.agentLastname}";
    }
  }

  String docProccessStatu(DeliveryDocModel docModel) {
    if (docModel.newProccessStatu != null) {
      if (docModel.newProccessStatu != "") {
        return docModel.newProccessStatu.toString();
      } else {
        if (docModel.proccesstatu == true) {
          return "İmzalandı";
        } else {
          return "İmza Bekliyor";
        }
      }
    } else {
      if (docModel.proccesstatu == true) {
        return "İmzalandı";
      } else {
        return "İmza Bekliyor";
      }
    }
  }

  RxString newProccessStatu = "".obs;
  RxString docStatu = "".obs;
  final MenuController menuController = MenuController();

  void changeNewProccessStat(String newStatu) {
    newProccessStatu.value = newStatu;
  }
}
