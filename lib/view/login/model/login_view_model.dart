import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/auth_controller.dart';
import 'package:saglamoglu_muhasebe/core/states/app_settings.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';
import 'package:saglamoglu_muhasebe/view/changepassword/change_password_view.dart';
import 'package:saglamoglu_muhasebe/view/main/main_view.dart';
import 'package:saglamoglu_muhasebe/view/main/model/main_view_model.dart';

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
  RxBool errBoxVisibility = false.obs;
  RxString errContent = "".obs;

  void changeObsecure() {
    if (obsecureText.value == true) {
      obsecureText.value = false;
    } else {
      obsecureText.value = true;
    }
  }

  void showErrBox(String errBoxContent) {
    errBoxVisibility.value = true;
    errContent.value = errBoxContent;
  }

  void closeErrBox() {
    errBoxVisibility.value = false;
  }

  Future<void> login(BuildContext context) async {
    if (emailController.text.isEmpty) {
      showErrBox("Lütfen geçerli bir email adresi giriniz.");
    } else if (passwordController.text.isEmpty) {
      showErrBox("Lütfen şifrenizi giriniz.");
    } else {
      if (formKey.currentState!.validate()) {
        var res = await authController.login(
            emailController.text, passwordController.text);

        if (res?.uid != null && res?.statu == true) {
          appUser.setUser(res!);
          if (context.mounted) {
            if (res.passwordNew == false) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => ChangePasswordView(),
                ),
              );
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => MainView(),
                ),
              );
              MainViewModel.instance.resetTimer();
              MainViewModel.instance.startTimer();
            }
          }
          AppSettings.init.startDataFetch();
        } else {
          if (kDebugMode) {
            print(res?.uid);
          }
        }
      }
    }
  }
}
