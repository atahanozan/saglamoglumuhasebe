import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/enums/navigation_enums.dart';
import 'package:saglamoglu_muhasebe/core/model/auth_model.dart';
import 'package:saglamoglu_muhasebe/core/model/customer_model.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/customer_controller.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';
import 'package:saglamoglu_muhasebe/view/authorized/authorized_view.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/compdeliverydocs/comp_delivery_docs_view.dart';
import 'package:saglamoglu_muhasebe/view/customers/customers_view.dart';
import 'package:saglamoglu_muhasebe/view/customers/model/customers_view_model.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/waitingdeliverydoc/waiting_delivery_docs_view.dart';
import 'package:saglamoglu_muhasebe/view/home/home_view.dart';
import 'package:saglamoglu_muhasebe/view/login/login_view.dart';

class MainViewModel extends GetxController {
  static bool get isRegistered => GetInstance().isRegistered<MainViewModel>();

  static MainViewModel get init => Get.put(MainViewModel());
  static MainViewModel get instance => Get.find<MainViewModel>();

  final TextEditingController tcknVknController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CustomerController get customerController => CustomerController();
  AppUser get user => AppUser.instance;

  CustomersViewModel customerViewModel = CustomersViewModel.init;

  List<NavigationEnums> get navigationEnumList =>
      NavigationEnums.values.toList();

  List<NavigationEnums> get nonAdminEnumList => [
        NavigationEnums.home,
        NavigationEnums.waitingdeliverydoc,
        NavigationEnums.authorized,
      ];

  List<Widget> get nonAdminPages => [
        HomeView(),
        WaitingDeliveryDocsView(),
        AuthorizedView(),
      ];

  Rx<NavigationEnums> selectedNavigationEnum = NavigationEnums.home.obs;

  RxInt selectedPageIndex = 0.obs;

  void changeSelectedPage(int newIndex, NavigationEnums newEnum) {
    selectedNavigationEnum.value = newEnum;
    selectedPageIndex.value = newIndex;
  }

  List<Widget> get pages => [
        HomeView(),
        CustomersView(),
        WaitingDeliveryDocsView(),
        CompDeliveryDocsView(),
        AuthorizedView(),
      ];

  Widget selectedPage(NavigationEnums navEnum) {
    switch (navEnum) {
      case NavigationEnums.home:
        return HomeView();
      case NavigationEnums.customer:
        return CustomersView();
      case NavigationEnums.waitingdeliverydoc:
        return WaitingDeliveryDocsView();
      case NavigationEnums.completeddeliverydoc:
        return CompDeliveryDocsView();
      case NavigationEnums.authorized:
        return AuthorizedView();
    }
  }

  RxDouble custmerAddPageSize = 0.0.obs;
  RxBool addCustomerVisibility = false.obs;

  void changePageSize(double newSize) {
    if (custmerAddPageSize.value == 0.0) {
      custmerAddPageSize.value = newSize;
      Future.delayed(const Duration(milliseconds: 500), () {
        addCustomerVisibility.value = true;
      });
    } else {
      custmerAddPageSize.value = 0.0;
      addCustomerVisibility.value = false;
    }
  }

  // RxString frontIdImage = "".obs;
  // RxString frontIdImagePath = "".obs;

  // Future<void> pickImage() async {
  //   final ImagePicker picker = ImagePicker();
  //   var pickedFile = await picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     var imageUint8le = await pickedFile.readAsBytes();
  //     print(imageUint8le);
  //     final blob = web.Blob([imageUint8le], 'application/png');
  //     final url = web.Url.createObjectUrlFromBlob(blob);
  //     frontIdImagePath.value = pickedFile.path;
  //     print("Resim adresi: $url");
  //     var base64Data = base64Encode(File(url).readAsBytesSync());
  //     print(base64Data);
  //     frontIdImage.value = base64Data;
  //   }
  // }

  Future<void> addCustomer(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (tcknVknController.text.isNotEmpty && nameController.text.isNotEmpty) {
        var result = await FirebaseFirestore.instance
            .collection("deliverycustomers")
            .where(
              Filter.or(
                Filter("customerStatu", isNull: true),
                Filter("customerStatu", isEqualTo: "A"),
              ),
            )
            .where("tcknvkn", isEqualTo: tcknVknController.text)
            .get();

        if (result.docs.isNotEmpty) {
          if (context.mounted) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                content: Text(
                    "${result.docs.first["name"]} isimli müşteri daha önce eklenmiş."),
                actions: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Tamam"),
                  ),
                ],
              ),
            );
          }
        } else {
          var customer = CustomerModel(
              id: DateTime.now().millisecondsSinceEpoch,
              date: DateTime.now().toString().split(" ")[0],
              name: nameController.text,
              tcknvkn: tcknVknController.text,
              telNo: phoneController.text,
              agentName: userAdmin.value.name,
              agentLastname: userAdmin.value.lastName,
              customerStatu: "A",
              agents: [
                "${DateTime.now()}&${user.thisUser.value.name} ${user.thisUser.value.lastName}"
              ]);

          customerController.createCustomer(customer);

          customerViewModel.getCustomerData();

          changePageSize(0.0);

          Future.delayed(const Duration(milliseconds: 100), () {
            nameController.clear();
            phoneController.clear();
            tcknVknController.clear();
          });
        }
      }
    }
  }

  Rx<AuthModel> userAdmin = AuthModel().obs;

  void getUserAdmin() async {
    var data = await user.getUserData();
    userAdmin = data.obs;
    update();
  }

  Future<void> userLogout(BuildContext context) async {
    user.logout();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => LoginView(),
      ),
    );
  }

  RxInt loginTime = 600.obs;
  RxBool loginAgain = false.obs;

  Timer? timer;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (newTime) {
      if (loginTime > 0) {
        loginTime.value--;
      } else {
        loginAgain.value = true;
        newTime.cancel();
      }
    });
  }

  void resetTimer() {
    loginTime.value = 600;
    loginAgain.value = false;
  }
}
