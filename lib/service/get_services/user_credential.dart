import 'package:get/get.dart';

class GetUserInfo extends GetxController {
  var customerName = "".obs;
  var customerLastName = "".obs;
  var customerUid = "".obs;
  var customerEmail = "".obs;
  var customerAdmin = false.obs;

  void updateUserDetails(
    String name,
    String lastName,
    String uid,
    String email,
    bool admin,
  ) {
    customerName.value = name;
    customerLastName.value = lastName;
    customerUid.value = uid;
    customerEmail.value = email;
    customerAdmin.value = admin;
  }
}
