import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/auth_controller.dart';

class AddUserViewModel extends GetxController {
  static bool get isRegistered =>
      GetInstance().isRegistered<AddUserViewModel>();

  static AddUserViewModel get init => Get.put(AddUserViewModel());

  static AddUserViewModel get instance => Get.find<AddUserViewModel>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  final AuthController authController = AuthController();

  RxBool admin = false.obs;

  void changeAdminStatu() {
    admin.value = !admin.value;
  }

  Future<void> createNewUser(
    String name,
    String lastName,
    String email,
    bool newAdmin,
    BuildContext context,
  ) async {
    authController.createUser(name, lastName, email, newAdmin);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Kullanıcı kaydedildi."),
        ),
      );
    }
  }

  Future<void> disableUser(
      String? uid, BuildContext context, String name) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("$name isimli kullanıcı deaktif edilecek ?"),
        actions: [
          ElevatedButton(
            onPressed: () {
              authController.disableUser(uid);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Kullanıcı pasife alındı"),
                ),
              );

              Navigator.pop(context);
            },
            child: Text("Tamam"),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("İptal"),
          ),
        ],
      ),
    );
  }
}
