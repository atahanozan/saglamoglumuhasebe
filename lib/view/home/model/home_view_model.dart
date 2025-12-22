import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/model/auth_model.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/tesdoc_controller.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';

class HomeViewModel extends GetxController {
  static bool get isRegistered => GetInstance().isRegistered<HomeViewModel>();

  static HomeViewModel get init => Get.put(HomeViewModel());
  static HomeViewModel get instance => Get.find<HomeViewModel>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TesdocController get tesdocController => TesdocController();

  AppUser get appUser => AppUser.init;

  static DateTime get today => DateTime.now();

  Rx<AuthModel> userInfo = AuthModel().obs;

  void getUserName() async {
    var name = await appUser.getUserData();

    userInfo = name.obs;
    update();
  }

  // RxList<int> deliveryDocDailyCount = <int>[1, 1, 1, 1, 1, 1, 1].obs;
  // RxList<int> deliveryDocDays = <int>[1, 1, 1, 1, 1, 1, 1].obs;

  // Future<void> addDocCount() async {
  //   for (var i = 0; i < 7; i++) {
  //     await FirebaseFirestore.instance
  //         .collection("deliverydocs")
  //         .where("statu", isEqualTo: true)
  //         .where("lastEditedDate",
  //             isEqualTo:
  //                 today.subtract(Duration(days: i)).toString().split(" ")[0])
  //         .count()
  //         .get()
  //         .then((value) {
  //       deliveryDocDailyCount[i] = value.count ?? 0;
  //       deliveryDocDays[i] = today.subtract(Duration(days: i)).day;
  //     });
  //     deliveryDocDailyCount.refresh();
  //     deliveryDocDays.refresh();
  //   }
  //   update();
  // }

  RxInt waitingDeliveryDocCount = 0.obs;
  RxInt copmleteDeliveryDocCount = 0.obs;
  RxInt totalDeliveryDocCount = 0.obs;

  void updateDeliveryDocCounts() async {
    var dataSource = firestore.collection("deliverydocs");

    waitingDeliveryDocCount.value = await dataSource
        .where("statu", isEqualTo: false)
        .count()
        .get()
        .then((value) {
      return value.count!;
    });
    copmleteDeliveryDocCount.value = await dataSource
        .where("statu", isEqualTo: true)
        .count()
        .get()
        .then((value) {
      return value.count!;
    });
    totalDeliveryDocCount.value = await dataSource.count().get().then((value) {
      return value.count!;
    });
  }

  RxInt kycStart = 0.obs;
  RxInt kycSign = 0.obs;
  RxInt kycComplete = 0.obs;
  RxInt ikaStart = 0.obs;
  RxInt ikaSign = 0.obs;
  RxInt ikaComplete = 0.obs;
  Rx<DateTime> tesDocFilterStartDate = DateTime(2025, 12, 16).obs;
  Rx<DateTime> tesDocFilterEndDateDate = DateTime.now().obs;

  Future<void> pickStartDate(
    BuildContext context,
    DateTime selectedDate,
    DateTime lastDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2025, 12, 16),
      lastDate: lastDate,
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      tesDocFilterStartDate.value = pickedDate;
    }
  }

  Future<void> pickEndDate(
    BuildContext context,
    DateTime selectedDate,
    DateTime startDate,
  ) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: startDate,
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      tesDocFilterEndDateDate.value = pickedDate;
    }
  }

  void clearKycDateFilter() {
    tesDocFilterStartDate.value = DateTime(2025, 12, 16);
    tesDocFilterEndDateDate.value = DateTime.now();
  }

  Future<void> updateKycStatuCounts(
      DateTime filterStartDate, DateTime filterEndDate) async {
    var kycSt = await tesdocController.getDataCount(
      "tesStatu",
      "1",
      filterStartDate,
      filterEndDate,
    );
    kycStart.value = kycSt ?? 0;
    var kycSi = await tesdocController.getDataCount(
      "tesStatu",
      "2",
      filterStartDate,
      filterEndDate,
    );
    kycSign.value = kycSi ?? 0;
    var kycComp = await tesdocController.getDataCount(
      "tesStatu",
      "3",
      filterStartDate,
      filterEndDate,
    );
    kycComplete.value = kycComp ?? 0;
    var ikaSt = await tesdocController.getDataCount(
      "ikaStatu",
      "1",
      filterStartDate,
      filterEndDate,
    );
    ikaStart.value = ikaSt ?? 0;
    var ikaSi = await tesdocController.getDataCount(
      "ikaStatu",
      "2",
      filterStartDate,
      filterEndDate,
    );
    ikaSign.value = ikaSi ?? 0;
    var ikaComp = await tesdocController.getDataCount(
      "ikaStatu",
      "3",
      filterStartDate,
      filterEndDate,
    );
    ikaComplete.value = ikaComp ?? 0;
  }
}
