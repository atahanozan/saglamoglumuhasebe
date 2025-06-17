import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/model/authorized_model.dart';
import 'package:saglamoglu_muhasebe/core/model/customer_model.dart';
import 'package:saglamoglu_muhasebe/core/model/doc_models.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/authorized_controller.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/customer_controller.dart';
import 'package:saglamoglu_muhasebe/core/network/modules/delivery_doc_controller.dart';
import 'package:saglamoglu_muhasebe/core/states/app_user.dart';
import 'package:saglamoglu_muhasebe/core/widget/custom_alert_card.dart';

class CustomersViewModel extends GetxController {
  static bool get isRegistered =>
      GetInstance().isRegistered<CustomersViewModel>();

  static CustomersViewModel get init => Get.put(CustomersViewModel());

  static CustomersViewModel get instance => Get.find<CustomersViewModel>();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController priceController = TextEditingController();
  final TextEditingController authorizedTcknController =
      TextEditingController();
  final TextEditingController authorizedNameController =
      TextEditingController();
  final TextEditingController editTcknController = TextEditingController();
  final TextEditingController editNameController = TextEditingController();
  final TextEditingController editTelNoController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<FormState> customerFormKey = GlobalKey<FormState>();

  CustomerController get customerController => CustomerController();
  DeliveryDocController get deliveryDocController => DeliveryDocController();
  AuthorizedController get authorizedController => AuthorizedController();
  AppUser get appUser => AppUser.init;

  RxList<CustomerModel> allCustomerData = <CustomerModel>[].obs;

  RxBool isFiltered = false.obs;
  RxString searchFilterContent = "".obs;

  Future<void> getCustomerData() async {
    var res = await customerController.getCustomers();

    allCustomerData = res.obs;
    update();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> dataStream() {
    switch (isFiltered.value) {
      case true:
        return FirebaseFirestore.instance
            .collection("deliverycustomers")
            .where("name", isGreaterThanOrEqualTo: searchFilterContent.value)
            .limit(10)
            .snapshots();

      case false:
        return FirebaseFirestore.instance
            .collection("deliverycustomers")
            .limit(20)
            .orderBy("id", descending: true)
            .snapshots();
    }
  }

  void updateFilterWithSearch(String filterName) {
    isFiltered.value = true;
    searchFilterContent.value = filterName;
  }

  void cleanilter() {
    searchController.clear();
    isFiltered.value = false;
    searchFilterContent.value = "";
    update();
  }

  Widget customerStatuIcon(String customerId) {
    if (customerId.characters.length == 11) {
      return Icon(
        Icons.account_circle_rounded,
        size: 18,
        color: Colors.black87,
      );
    } else {
      return Icon(
        Icons.cases_rounded,
        size: 18,
        color: Colors.black87,
      );
    }
  }

  Widget dateFormat(String? dateTime, BuildContext context) {
    String day = dateTime.toString().split("-")[2];
    String month = dateTime.toString().split("-")[1];

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          day,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(month),
      ],
    );
  }

  void deleteCustomer(String? docId, String? name, BuildContext context) {
    showDialog(
        context: context,
        builder: (_) => CustomAlertCard(
              title: name.toString(),
              message: "İlgili müşteri silinecektir.",
              btnName: "Sil",
              actionFunc: () {
                customerController.deleteCustomer(docId);
                Navigator.pop(context);
                getCustomerData();
              },
            ));
  }

  RxDouble addDocWidth = 0.0.obs;
  RxBool addDocVisibilty = false.obs;
  RxBool addAuthorizeVisibility = false.obs;
  RxBool isDeliveryDoc = false.obs;
  RxBool errShow = false.obs;
  RxString companyName = "Sağlam".obs;
  RxString docType = "".obs;
  Rx<CustomerModel> addDocCustomer = CustomerModel().obs;

  void changeDocWidth(double newWidth, CustomerModel customer, bool isDelivery,
      String? newCustomerTckn, String? newCustomerName) {
    if (addDocWidth.value == 0.0) {
      addDocWidth.value = newWidth;
      addDocCustomer.value = customer;
      isDeliveryDoc.value = isDelivery;
      customerTckn.value = newCustomerTckn.toString();
      customerName.value = newCustomerName.toString();
      if (isDelivery) {
        docType.value = "Teslim Belgesi Ekle";
      } else {
        docType.value = "Yetki Belgesi Ekle";
      }
      Future.delayed(const Duration(milliseconds: 500), () {
        addDocVisibilty.value = true;
      });
    } else {
      addDocWidth.value = 0.0;
      addDocVisibilty.value = false;
      addDocCustomer.value = CustomerModel();
      isDeliveryDoc.value = false;
      addAuthorizeVisibility.value = false;
      docType.value = "";
      customerTckn.value = "";
      customerName.value = "";
    }
  }

  void changeCompanyName(String newCompany) {
    companyName.value = newCompany;
  }

  void closeErrorBox() {
    errShow.value = false;
  }

  void showErrorBox() {
    errShow.value = true;
  }

  List<String> get currencies => ["TL", "USD", "EUR"];
  List<String> get docTypeList => ["Talimat", "Vekaletname"];

  RxString docTypeInit = "Talimat".obs;

  void updateSelectedDocType(String? newDocType) {
    docTypeInit.value = newDocType.toString();
  }

  RxString selectedCurrency = "TL".obs;

  void updateSelectedCurrency(String? newCurrency) {
    selectedCurrency.value = newCurrency.toString();
  }

  Rx<DateTime?> initialDate = DateTime.now().obs;
  Rx<DateTime?> initialDateSecond =
      DateTime.now().add(const Duration(days: 365)).obs;

  Future<void> updateDate(BuildContext context) async {
    var result = await showDatePicker(
        context: context,
        firstDate: DateTime(2020, 1, 1),
        lastDate: DateTime(2050, 1, 1),
        initialDate: initialDate.value);

    initialDate.value = result;
  }

  void addDeliveryDoc(CustomerModel model, BuildContext context) {
    if (initialDate.value == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Lütfen Tarih Giriniz"),
        ),
      );
    } else {
      var result = DeliveryDocModel(
        name: model.name,
        tcknvkn: model.tcknvkn,
        price: priceController.text,
        company: companyName.value,
        date: initialDate.value.toString().split(" ")[0],
        agentName: appUser.thisUser.value.name,
        agentLastname: appUser.thisUser.value.lastName,
        currency: selectedCurrency.value,
        id: DateTime.now().millisecondsSinceEpoch,
        statu: false,
        proccesstatu: false,
      );

      deliveryDocController.createDeliveryDoc(result);
      Future.delayed(const Duration(milliseconds: 100), () {
        priceController.clear();
        initialDate.value = DateTime.now();
        update();
      });
    }
  }

  RxString customerTckn = "".obs;
  RxString customerName = "".obs;

  void updateCustomerInfo(String? newCustomerTckn, String? newCustomerName) {}

  void addAuthorized(String? customertckn, String? customername) {
    var data = AuthorizedModel(
      firstdate: initialDate.toString().split(" ")[0],
      seconddate: initialDateSecond.toString().split(" ")[0],
      customertckn: customertckn,
      customername: customername,
      authorizedtckn: authorizedTcknController.text,
      authorizedname: authorizedNameController.text,
      doctype: docTypeInit.value,
    );

    authorizedController.createAuthorizedDocument(data);

    Future.delayed(const Duration(milliseconds: 100), () {
      authorizedTcknController.clear();
      authorizedNameController.clear();
    });
  }

  RxBool editCustomer = false.obs;
  RxInt editCustomerIndex = 0.obs;

  void updateCustomerEditable(
      int dataIndex, String? name, String? tckn, String? telno) {
    if (editCustomer.value == false) {
      editCustomer.value = true;
      editCustomerIndex.value = dataIndex;
      editNameController.text = name.toString();
      editTcknController.text = tckn.toString();
      editTelNoController.text = telno.toString();
    } else {
      editCustomer.value = false;
      editCustomerIndex.value = 0;
      editNameController.clear();
      editTcknController.clear();
      editTelNoController.clear();
    }
  }

  void updateCustomerData(String? dataId) {
    if (editCustomer.value == true) {
      customerController.updateCustomer(dataId, {
        "name": editNameController.text,
        "tcknvkn": editTcknController.text,
        "telNo": editTelNoController.text,
      });

      Future.delayed(const Duration(milliseconds: 100), () {
        editCustomer.value = false;
        editCustomerIndex.value = 0;
        editNameController.clear();
        editTcknController.clear();
        editTelNoController.clear();
      });
    }
  }
}
