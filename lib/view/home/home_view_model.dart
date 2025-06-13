import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/model/auth_model.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';

class HomeViewModel extends GetxController {
  static bool get isRegistered => GetInstance().isRegistered<HomeViewModel>();

  static HomeViewModel get init => Get.put(HomeViewModel());
  static HomeViewModel get instance => Get.find<HomeViewModel>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  AppUser get appUser => AppUser.init;

  Rx<AuthModel> userInfo = AuthModel().obs;

  void getUserName() async {
    var name = await appUser.getUserData();

    userInfo = name.obs;
    update();
  }

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
}
