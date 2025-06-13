import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/model/auth_model.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/auth_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppUser extends GetxController {
  static bool get isRegistered => GetInstance().isRegistered<AppUser>();

  static AppUser get init => Get.put(AppUser());
  static AppUser get instance => Get.find<AppUser>();

  Rx<AuthModel> thisUser = AuthModel().obs;

  void setUser(AuthModel newUser) {
    thisUser = newUser.obs;
    update();
    setUserData(newUser);
  }

  void logout() {
    thisUser = AuthModel().obs;
    update();
    AuthController().logout();
  }

  Future<void> setUserData(AuthModel newUser) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("uid", newUser.uid.toString());
    prefs.setString("email", newUser.email.toString());
    prefs.setString("name", newUser.name.toString());
    prefs.setString("lastName", newUser.lastName.toString());
    prefs.setBool("admin", newUser.admin ?? false);
  }

  Future<AuthModel> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var res = AuthModel(
      email: prefs.getString("email"),
      name: prefs.getString("name"),
      uid: prefs.getString("uid"),
      lastName: prefs.getString("lastName"),
      admin: prefs.getBool("admin"),
    );

    return res;
  }
}
