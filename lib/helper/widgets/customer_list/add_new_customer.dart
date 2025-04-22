import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:saglamoglu_muhasebe/helper/ui/uppercase_text_formatter.dart';
import 'package:saglamoglu_muhasebe/service/data_services.dart';

class AddNewCustomer extends StatefulWidget {
  const AddNewCustomer({super.key});

  @override
  State<AddNewCustomer> createState() => _AddNewCustomerState();
}

class _AddNewCustomerState extends State<AddNewCustomer> {
  final TextEditingController tcknController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DataServices dataServices = DataServices();
  List<String> tckns = [];

  Future<void> addTckn() async {
    await firestore.collection("deliverycustomers").get().then((value) {
      for (var element in value.docs) {
        tckns.add(element["tcknvkn"]);
      }
    });
  }

  @override
  void initState() {
    addTckn();
    super.initState();
  }

  @override
  void dispose() {
    tcknController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size pageSize = MediaQuery.of(context).size;
    return Container(
      width: pageSize.width,
      margin: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Expanded(
                flex: 1,
                child: Text("TCKN / VKN"),
              ),
              const Text("   "),
              Expanded(
                flex: 3,
                child: TextField(
                  controller: tcknController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: '###########',
                      filter: {'#': RegExp(r'[0-9]')},
                    ),
                  ],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Expanded(
                flex: 1,
                child: Text("Ad Soyad / Ünvan"),
              ),
              const Text("   "),
              Expanded(
                flex: 3,
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  inputFormatters: [
                    UppercaseTextFormatter(),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          ElevatedButton(
              style:
                  ElevatedButton.styleFrom(fixedSize: Size(pageSize.width, 20)),
              onPressed: () {
                if (tckns.contains(tcknController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Bu müşteri daha önce eklenmiş !"),
                    ),
                  );
                } else {
                  if (tcknController.text.isNotEmpty &&
                      nameController.text.isNotEmpty &&
                      tcknController.text.length > 9) {
                    dataServices
                        .addCustomer(nameController.text, tcknController.text)
                        .whenComplete(() {
                      addTckn();
                      setState(() {
                        tcknController.clear();
                        nameController.clear();
                      });
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Lütfen bilgileri eksiksiz doldurunuz !"),
                      ),
                    );
                  }
                }
              },
              child: const Text("Kaydet")),
        ],
      ),
    );
  }
}
