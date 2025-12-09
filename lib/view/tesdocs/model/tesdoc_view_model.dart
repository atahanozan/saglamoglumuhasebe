import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/model/tesdoc_model.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/tesdoc_controller.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';

class TesdocViewModel extends GetxController {
  static bool get isRegistered => GetInstance().isRegistered<TesdocViewModel>();

  static TesdocViewModel get init => Get.put(TesdocViewModel());

  static TesdocViewModel get instance => Get.find<TesdocViewModel>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  TesdocController get tesdocController => TesdocController();
  AppUser get appUser => AppUser.init;

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
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
              "${tesdocModel.customerName} isimli müşteri için açılan talep silinecektir."),
          actions: [
            OutlinedButton(
                onPressed: () => Navigator.pop(context), child: Text("İptal")),
            ElevatedButton(
                onPressed: () async {
                  var res = await tesdocController.deleteData(tesdocModel);
                  if (res && context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: Text("Sil")),
          ],
        ),
      );
    }
  }

  void updateTesDoc(
    Map<String, dynamic> newData,
    BuildContext context,
    String? docId,
  ) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Müşteri durumu güncellenecek onaylıyor musunuz?"),
              actions: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("İptal"),
                ),
                ElevatedButton(
                    onPressed: () async {
                      var res =
                          await tesdocController.updateData(newData, docId);
                      if (res && context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Evet"))
              ],
            ));
  }
}
