import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/model/tesdoc_model.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/tesdoc_controller.dart';
import 'package:saglamoglu_muhasebe/core/states/app_settings.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';

class TesdocViewModel extends GetxController {
  static bool get isRegistered => GetInstance().isRegistered<TesdocViewModel>();

  static TesdocViewModel get init => Get.put(TesdocViewModel());

  static TesdocViewModel get instance => Get.find<TesdocViewModel>();

  final TextEditingController searchContoller = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TesdocController get tesdocController => TesdocController();
  AppUser get appUser => AppUser.init;
  AppSettings get appSettings => AppSettings.init;

  Rx<Stream> tesStream = TesdocController().tesDocStream(0, "", "").obs;
  RxString filterStatu = "".obs;

  void searchWithValue(String searchValue) {
    tesStream.value =
        tesdocController.tesDocStream(2, "customerName", searchValue);
  }

  void clearSearch() {
    searchContoller.clear();
    tesStream.value = tesdocController.tesDocStream(0, "", "");
    filterStatu.value = "";
  }

  void filterData(String filterName, String? filterValue) {
    tesStream.value = tesdocController.tesDocStream(1, filterName, filterValue);
    filterStatu.value = "$filterName-$filterValue";
  }

  void deleteTesDoc(
    String user,
    TesdocModel tesdocModel,
    BuildContext context,
  ) {
    if (user != tesdocModel.starterUser) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Bir talebi sadece oluşturan kişiler iptal edebilir!"),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.pop(context), child: Text("Kapat")),
          ],
        ),
      );
    } else {
      tesdocController.deleteData(tesdocModel, context);
    }
  }

  void updateTesDoc(
    Map<String, dynamic> newData,
    BuildContext context,
    String? docId,
  ) {
    tesdocController.updateData(newData, docId, context);
  }
}
