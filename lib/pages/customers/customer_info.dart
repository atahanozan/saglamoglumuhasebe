import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/helper/custom_widget.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/customer_list/download_customer_info.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/custom_dialog.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/customer_list/customer_info_table.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/customer_list/send_customer_doc.dart';

class CustomerInfo extends StatefulWidget {
  const CustomerInfo({
    super.key,
    required this.title,
    required this.tckn,
    required this.adress,
    required this.placeofbirth,
    required this.job,
    required this.iban,
    required this.docId,
    required this.statu,
    required this.frontidimg,
    required this.backidimg,
    required this.phoneNumber,
    required this.microId,
  });

  final String title;
  final String tckn;
  final String adress;
  final String placeofbirth;
  final String job;
  final String iban;
  final String frontidimg;
  final String backidimg;
  final String phoneNumber;
  final String microId;
  final String? docId;
  final bool statu;

  @override
  State<CustomerInfo> createState() => _CustomerInfoState();
}

class _CustomerInfoState extends State<CustomerInfo> {
  final CustomWidgets customWidgets = CustomWidgets();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final CustomerInfoFunctions _functions = CustomerInfoFunctions();
  bool statu = false;
  bool idVisibility = false;

  Future<void> deleteCustomer(BuildContext context) async {
    _firestore.collection("customers").doc(widget.docId).delete();

    Navigator.pop(context);
  }

  @override
  void initState() {
    setState(() {
      statu = widget.statu;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: SingleChildScrollView(
                child: CustomerInfoTable(
                  title: widget.title,
                  tckn: widget.tckn,
                  adress: widget.adress,
                  placeofbirth: widget.placeofbirth,
                  job: widget.job,
                  iban: widget.iban,
                  frontidimg: widget.frontidimg,
                  backidimg: widget.backidimg,
                  phoneNumber: widget.phoneNumber,
                  microId: widget.microId,
                  docId: widget.docId,
                ),
              ),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(left: 20),
              width: 250,
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        fixedSize:
                            Size.fromWidth(MediaQuery.of(context).size.width)),
                    onPressed: () {
                      _functions.downloadCustomerInfo(
                        widget.tckn,
                        widget.title,
                        widget.iban,
                        widget.adress,
                        widget.placeofbirth,
                        widget.job,
                        widget.iban,
                        context,
                      );
                    },
                    child: const Text("Bilgileri İndir"),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        fixedSize:
                            Size.fromWidth(MediaQuery.of(context).size.width)),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) => CustomDialog(
                                finalWdgt: SendCustomerDoc(
                                  customerName: widget.title,
                                  tckn: widget.tckn,
                                  edit: false,
                                ),
                                customActions: [
                                  OutlinedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Kapat"),
                                  ),
                                ],
                              ));
                    },
                    child: const Text("Teslim Formu Oluştur"),
                  ),
                  const Spacer(),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      fixedSize:
                          Size.fromWidth(MediaQuery.of(context).size.width),
                      foregroundColor: Colors.red.shade800,
                    ),
                    onPressed: () {
                      // showDialog(
                      //   context: context,
                      //   builder: (_) => CustomDialog(
                      //     finalWdgt: const Text("Müşteri kaydını sil?"),
                      //     customActions: [
                      //       ElevatedButton(
                      //         onPressed: () {
                      //           deleteCustomer(context);

                      //           Navigator.pushReplacement(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (_) => const CustomersList()));
                      //         },
                      //         child: const Text("Evet"),
                      //       ),
                      //       OutlinedButton(
                      //         onPressed: () {
                      //           Navigator.pop(context);
                      //         },
                      //         child: const Text("Hayır"),
                      //       ),
                      //     ],
                      //   ),
                      // );
                    },
                    child: const Text("Kaydı Sil"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
