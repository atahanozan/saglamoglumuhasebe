import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/enums/navigation_enums.dart';
import 'package:saglamoglu_muhasebe/core/model/auth_model.dart';
import 'package:saglamoglu_muhasebe/core/model/customer_model.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/customer_controller.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';
import 'package:saglamoglu_muhasebe/view/authorized/authorized_view.dart';
import 'package:saglamoglu_muhasebe/view/compdeliverydocs/comp_delivery_docs_view.dart';
import 'package:saglamoglu_muhasebe/view/customers/customers_view.dart';
import 'package:saglamoglu_muhasebe/view/customers/model/customers_view_model.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/waiting_delivery_docs_view.dart';
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
  AppUser get user => AppUser.init;

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

  Future<void> addCustomer(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      if (tcknVknController.text.isNotEmpty && nameController.text.isNotEmpty) {
        var result = await FirebaseFirestore.instance
            .collection("deliverycustomers")
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
          );

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
}
