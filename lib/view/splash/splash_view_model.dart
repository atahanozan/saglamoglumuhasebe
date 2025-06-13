import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/states/app_settings.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';
import 'package:saglamoglu_muhasebe/view/login/login_view.dart';
import 'package:saglamoglu_muhasebe/view/main/main_view.dart';

class SplashViewModel extends GetxController {
  static bool get isRegistered => GetInstance().isRegistered<SplashViewModel>();

  static SplashViewModel get init => Get.put(SplashViewModel());
  static SplashViewModel get instance => Get.find<SplashViewModel>();

  AppUser get appUser => AppUser.instance;

  Timer? navigateByData;

  Future<void> updateSplash(BuildContext context) async {
    var res = await AppUser.init.getUserData();

    navigateByData = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (res.uid != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => MainView(),
          ),
        );
        AppSettings.init.startDataFetch();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => LoginView(),
          ),
        );
      }

      timer.cancel();
    });
  }
}
