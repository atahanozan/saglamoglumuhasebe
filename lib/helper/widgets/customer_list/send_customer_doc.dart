import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/customer_list/customer_delivery_doc.dart';

class SendCustomerDoc extends StatefulWidget {
  const SendCustomerDoc({
    super.key,
    required this.customerName,
    required this.tckn,
    required this.edit,
    this.id = "",
    this.docName = "",
    this.dateTime = "",
    this.docId = 1,
  });

  final String customerName;
  final String tckn;
  final bool edit;
  final String id;
  final String docName;
  final String dateTime;
  final int docId;

  @override
  State<SendCustomerDoc> createState() => _SendCustomerDocState();
}

class _SendCustomerDocState extends State<SendCustomerDoc> {
  final CustomerDeliveryDoc _deliveryDoc = CustomerDeliveryDoc();
  final TextEditingController _priceTlController = TextEditingController();
  final TextEditingController _priceKrsController = TextEditingController();
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  double price = 0;
  String krs = "0";
  String selectedRelating = "MUSA";
  String selectedCompany = "SAĞLAMOĞLU";
  String selectedProduct = "HAS ALTIN";
  String dateTime = "";
  DateTime now = DateTime.now();
  void setPrice() {
    final List<String> priceTlList =
        _priceTlController.text.split('.').toList();
    final String priceTl = priceTlList.join("");
    if (_priceKrsController.text.isEmpty) {
      setState(() {
        price = int.parse(priceTl) as double;
      });
    } else {
      setState(() {
        price =
            int.parse(priceTl) + (int.parse(_priceKrsController.text) / 100);
      });
    }
  }

  List<String> dropDownCustomName = [
    "MUSA",
    "MESUT",
    "CESUR",
  ];
  List<String> dropDownCustomCompany = [
    "SAĞLAMOĞLU",
    "ELMİNA",
  ];
  List<String> dropDownCustomProduct = [
    "HAS ALTIN",
    "HAS GÜMÜŞ",
  ];

  @override
  void initState() {
    setState(() {
      dateTime = "${now.day}.${now.month}.${now.year}";
    });
    super.initState();
  }

  @override
  void dispose() {
    _priceTlController.dispose();
    _priceKrsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Expanded(child: Text("İlgili")),
                const Text(":"),
                Expanded(
                    child: DropdownButton(
                  value: selectedRelating,
                  onChanged: (value) {
                    setState(() {
                      selectedRelating = value.toString();
                    });
                  },
                  items: dropDownCustomName
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
              ],
            ),
            Row(
              children: [
                const Expanded(child: Text("Firma")),
                const Text(":"),
                Expanded(
                    child: DropdownButton(
                  value: selectedCompany,
                  onChanged: (value) {
                    setState(() {
                      selectedCompany = value.toString();
                    });
                  },
                  items: dropDownCustomCompany
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
              ],
            ),
            Row(
              children: [
                const Expanded(child: Text("Ürün")),
                const Text(":"),
                Expanded(
                    child: DropdownButton(
                  value: selectedProduct,
                  onChanged: (value) {
                    setState(() {
                      selectedProduct = value.toString();
                    });
                  },
                  items: dropDownCustomProduct
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )),
              ],
            ),
            Text(
              "Tutar",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _priceTlController,
                      inputFormatters: [
                        MaskTextInputFormatter(
                          mask: '###.###.###.###.###',
                          filter: {'#': RegExp(r'[0-9]')},
                        )
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Tutar",
                        suffixText: "TL",
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _priceKrsController,
                      inputFormatters: [
                        MaskTextInputFormatter(
                          mask: '##',
                          filter: {'#': RegExp(r'[0-9]')},
                        )
                      ],
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Tutar",
                        suffixText: "KRŞ",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: widget.edit ? false : true,
              child: OutlinedButton(
                onPressed: () {
                  setPrice();
                  if (_priceTlController.text.isNotEmpty) {
                    Navigator.pop(context);

                    _deliveryDoc.downloadCustomerDeliveryDoc(
                      widget.customerName,
                      widget.tckn,
                      selectedCompany,
                      "$price",
                      selectedProduct,
                      selectedRelating,
                      context,
                    );
                    _firebaseFirestore.collection("CustomerDeliveryDocs").add({
                      "customerName": widget.customerName,
                      "companyName": selectedCompany,
                      "dateTime": dateTime,
                      "docId": now.millisecondsSinceEpoch,
                      "price": price,
                      "relating": selectedRelating,
                      "tckn": widget.tckn,
                      "product": selectedProduct,
                      "isNew": true,
                      "docName":
                          'ALTIN GÜMÜŞ Teslim Tesellüm - $selectedCompany - ${widget.customerName} - $dateTime.pdf'
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Lütfen Tutar Giriniz !")));
                  }
                },
                child: const Text("Teslim Oluştur"),
              ),
            ),
            Visibility(
              visible: widget.edit,
              child: ElevatedButton(
                onPressed: () {
                  setPrice();
                  Navigator.pop(context);
                  Future.delayed(const Duration(milliseconds: 100), () {
                    _firebaseFirestore
                        .collection("CustomerDeliveryDocs")
                        .doc(widget.id)
                        .set({
                      "customerName": widget.customerName,
                      "companyName": selectedCompany,
                      "dateTime": widget.dateTime,
                      "docId": widget.docId,
                      "price": price,
                      "relating": selectedRelating,
                      "tckn": widget.tckn,
                      "product": selectedProduct,
                      "isNew": true,
                      "docName": widget.docName,
                    });
                  });
                },
                child: const Text("Düzenle"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
