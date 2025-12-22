import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';
import 'package:saglamoglu_muhasebe/view/authorized/model/authorized_view_model.dart';
import 'package:saglamoglu_muhasebe/view/customers/model/customers_view_model.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/waitingdeliverydoc/model/delivery_docs_view_model.dart';
import 'package:saglamoglu_muhasebe/view/home/model/home_view_model.dart';
import 'package:saglamoglu_muhasebe/view/main/model/main_view_model.dart';

class AppSettings extends GetxController {
  static bool get isRegistered => GetInstance().isRegistered<AppSettings>();

  static AppSettings get init => Get.put(AppSettings());

  static AppSettings get instance => Get.find<AppSettings>();

  CustomersViewModel get customerViewMode => CustomersViewModel.instance;
  DeliveryDocsViewModel get deliveryDocViewModel =>
      DeliveryDocsViewModel.instance;
  AuthorizedViewModel get authorizedViewModel => AuthorizedViewModel.instance;
  HomeViewModel get homeViewModel => HomeViewModel.instance;
  MainViewModel get mainViewModel => MainViewModel.instance;
  AppUser get appUser => AppUser.instance;

  final DateTime now = DateTime.now();
  final DateTime startDate = DateTime(2025, 12, 16);

  Future<void> setAppUserInfo() async {
    var res = await appUser.getUserData();

    appUser.setUser(res);
  }

  Future<void> startDataFetch() async {
    customerViewMode.getCustomerData();
    deliveryDocViewModel.getAllData(false);
    authorizedViewModel.getAllData();
    homeViewModel.updateDeliveryDocCounts();
    homeViewModel.getUserName();
    homeViewModel.updateKycStatuCounts(startDate, now);
    mainViewModel.getUserAdmin();
    deliveryDocViewModel.getUserName();
    setAppUserInfo();
  }
}
