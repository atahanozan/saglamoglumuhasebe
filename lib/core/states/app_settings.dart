import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';
import 'package:saglamoglu_muhasebe/view/authorized/model/authorized_view_model.dart';
import 'package:saglamoglu_muhasebe/view/compdeliverydocs/model/comp_delivery_docs_view_model.dart';
import 'package:saglamoglu_muhasebe/view/customers/model/customers_view_model.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/model/delivery_docs_view_model.dart';
import 'package:saglamoglu_muhasebe/view/home/model/home_view_model.dart';
import 'package:saglamoglu_muhasebe/view/main/model/main_view_model.dart';

class AppSettings extends GetxController {
  static bool get isRegistered => GetInstance().isRegistered<AppSettings>();

  static AppSettings get init => Get.put(AppSettings());

  static AppSettings get instance => Get.find<AppSettings>();

  CustomersViewModel get customerViewMode => CustomersViewModel.instance;
  DeliveryDocsViewModel get deliveryDocViewModel =>
      DeliveryDocsViewModel.instance;
  CompDeliveryDocsViewModel get compDeliveryDocsModel =>
      CompDeliveryDocsViewModel.instance;
  AuthorizedViewModel get authorizedViewModel => AuthorizedViewModel.instance;
  HomeViewModel get homeViewModel => HomeViewModel.instance;
  MainViewModel get mainViewModel => MainViewModel.instance;
  AppUser get appUser => AppUser.instance;

  Future<void> setAppUserInfo() async {
    var res = await appUser.getUserData();

    appUser.setUser(res);
  }

  Future<void> startDataFetch() async {
    customerViewMode.getCustomerData();
    deliveryDocViewModel.getAllData();
    compDeliveryDocsModel.getUserName();
    compDeliveryDocsModel.getAllData();
    authorizedViewModel.getAllData();
    homeViewModel.updateDeliveryDocCounts();
    homeViewModel.getUserName();
    homeViewModel.addDocCount();
    mainViewModel.getUserAdmin();
    deliveryDocViewModel.getUserName();
    setAppUserInfo();
  }
}
