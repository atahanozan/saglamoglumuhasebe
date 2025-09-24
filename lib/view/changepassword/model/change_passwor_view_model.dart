import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/auth_controller.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';

class ChangePassworViewModel extends GetxController {
  static bool get isRegistered =>
      GetInstance().isRegistered<ChangePassworViewModel>();

  static ChangePassworViewModel get init => Get.put(ChangePassworViewModel());
  static ChangePassworViewModel get instance =>
      Get.find<ChangePassworViewModel>();

  AppUser get appUser => AppUser.init;
  AuthController get authController => AuthController();

  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordAgainController =
      TextEditingController();

  RxBool isObsecure = true.obs;
  RxBool isContainsLetter = false.obs;
  RxBool isContainsNumber = false.obs;
  RxBool isContainsSpecialCharacter = false.obs;
  RxBool isLongerEnough = false.obs;
  RxBool isPasswordsEqual = false.obs;

  void changeContainLetter(bool newStatu) {
    isContainsLetter.value = newStatu;
  }

  void changeContainNumber(bool newStatu) {
    isContainsNumber.value = newStatu;
  }

  void changeContainSpecialCharacter(bool newStatu) {
    isContainsSpecialCharacter.value = newStatu;
  }

  void changeIsLongerEnough(bool newStatu) {
    isLongerEnough.value = newStatu;
  }

  void changeIsPasswordsEqual(bool newStatu) {
    isPasswordsEqual.value = newStatu;
  }

  void changeObsecure() {
    isObsecure.value = !isObsecure.value;
  }

  Future<void> changePassword(
    String newPassword,
    BuildContext context,
  ) async {
    var thisUser = FirebaseAuth.instance.currentUser;
    if (thisUser != null) {
      if (newPassword.contains(" ")) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Şifre boşluk içermemelidir.")));
      } else {
        authController.changePassword(newPassword, thisUser);
        FirebaseFirestore.instance
            .collection("users")
            .doc(thisUser.uid)
            .update({
          "passwordNew": true,
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Şifreniz başarı ile değiştirildi")));
      }
    }
  }
}
