import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/auth_controller.dart';
import 'package:saglamoglu_muhasebe/core/states/app_settings.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';
import 'package:saglamoglu_muhasebe/view/main/main_view.dart';

class LoginViewModel extends GetxController {
  static bool get isRegistered => GetInstance().isRegistered<LoginViewModel>();

  static LoginViewModel get init => Get.put(LoginViewModel());
  static LoginViewModel get instance => Get.find<LoginViewModel>();

  AppUser get appUser => AppUser.init;
  AuthController get authController => AuthController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  RxBool obsecureText = true.obs;

  void changeObsecure() {
    if (obsecureText.value == true) {
      obsecureText.value = false;
    } else {
      obsecureText.value = true;
    }
  }

  Future<void> login(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      var res = await authController.login(
          emailController.text, passwordController.text);

      if (res?.uid != null) {
        appUser.setUser(res!);
        if (context.mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => MainView(),
            ),
          );
        }
        AppSettings.init.startDataFetch();
      } else {
        print(res?.uid);
      }
    }
  }
}
