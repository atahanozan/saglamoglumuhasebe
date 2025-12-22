import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/view/adduser/model/add_user_view_model.dart';
import 'package:saglamoglu_muhasebe/view/authorized/model/authorized_view_model.dart';
import 'package:saglamoglu_muhasebe/view/changepassword/model/change_passwor_view_model.dart';
import 'package:saglamoglu_muhasebe/view/customers/model/customers_view_model.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/waitingdeliverydoc/model/delivery_docs_view_model.dart';
import 'package:saglamoglu_muhasebe/view/home/model/home_view_model.dart';
import 'package:saglamoglu_muhasebe/view/login/model/login_view_model.dart';
import 'package:saglamoglu_muhasebe/view/login/widgets/doublelogin/model/double_login_view_model.dart';
import 'package:saglamoglu_muhasebe/view/main/model/main_view_model.dart';
import 'package:saglamoglu_muhasebe/view/splash/model/splash_view_model.dart';
import 'package:saglamoglu_muhasebe/view/tesdocs/model/tesdoc_view_model.dart';

class SingletonManager {
  SingletonManager._() {
    Get.put(AuthorizedViewModel());
    Get.put(CustomersViewModel());
    Get.put(DeliveryDocsViewModel());
    Get.put(HomeViewModel());
    Get.put(LoginViewModel());
    Get.put(MainViewModel());
    Get.put(SplashViewModel());
    Get.put(ChangePassworViewModel());
    Get.put(DoubleLoginViewModel());
    Get.put(AddUserViewModel());
    Get.put(TesdocViewModel());
  }

  static final SingletonManager _instance = SingletonManager._();

  static SingletonManager get instance => _instance;
}
