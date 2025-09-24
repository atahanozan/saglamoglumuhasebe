import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/auth_controller.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';

class DoubleLoginViewModel extends GetxController {
  static bool get isRegistered =>
      GetInstance().isRegistered<DoubleLoginViewModel>();

  static DoubleLoginViewModel get init => Get.put(DoubleLoginViewModel());
  static DoubleLoginViewModel get instance => Get.find<DoubleLoginViewModel>();

  AppUser get appUser => AppUser.init;
  AuthController get authController => AuthController();

  void logout() {
    authController.logout();
  }
}
