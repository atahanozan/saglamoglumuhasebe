import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';
import 'package:saglamoglu_muhasebe/view/authorized/authorized_view_model.dart';
import 'package:saglamoglu_muhasebe/view/customers/customers_view_model.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/delivery_docs_view_model.dart';
import 'package:saglamoglu_muhasebe/view/home/home_view_model.dart';
import 'package:saglamoglu_muhasebe/view/main/main_view_model.dart';

class AppSettings extends GetxController {
  static bool get isRegistered => GetInstance().isRegistered<AppSettings>();

  static AppSettings get init => Get.put(AppSettings());

  static AppSettings get instance => Get.find<AppSettings>();

  CustomersViewModel get customerViewMode => CustomersViewModel.init;
  DeliveryDocsViewModel get deliveryDocViewModel => DeliveryDocsViewModel.init;
  AuthorizedViewModel get authorizedViewModel => AuthorizedViewModel.init;
  HomeViewModel get homeViewModel => HomeViewModel.init;
  MainViewModel get mainViewModel => MainViewModel.init;
  AppUser get appUser => AppUser.init;

  Future<void> setAppUserInfo() async {
    var res = await appUser.getUserData();

    appUser.setUser(res);
  }

  Future<void> startDataFetch() async {
    customerViewMode.getCustomerData();
    deliveryDocViewModel.getAllCompleteData();
    deliveryDocViewModel.getAllData();
    authorizedViewModel.getAllData();
    homeViewModel.updateDeliveryDocCounts();
    homeViewModel.getUserName();
    homeViewModel.addDocCount();
    mainViewModel.getUserAdmin();
    deliveryDocViewModel.getUserName();
    setAppUserInfo();
  }
}
