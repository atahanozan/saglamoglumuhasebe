import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:saglamoglu_muhasebe/helper/ui/uppercase_text_formatter.dart';
import 'package:saglamoglu_muhasebe/service/data_services.dart';

class AddNewCustomer extends StatefulWidget {
  const AddNewCustomer({super.key, required this.tckns});

  final List<String> tckns;

  @override
  State<AddNewCustomer> createState() => _AddNewCustomerState();
}

class _AddNewCustomerState extends State<AddNewCustomer> {
  final TextEditingController tcknController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final DataServices dataServices = DataServices();

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
                  onEditingComplete: () {
                    if (widget.tckns.contains(tcknController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Bu müşteri daha önce eklenmiş !"),
                        ),
                      );
                    } else {
                      if (tcknController.text.isNotEmpty &&
                          nameController.text.isNotEmpty &&
                          tcknController.text.length > 10) {
                        dataServices
                            .addCustomer(
                                nameController.text, tcknController.text)
                            .whenComplete(() {
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
                            content:
                                Text("Lütfen bilgileri eksiksiz doldurunuz !"),
                          ),
                        );
                      }
                    }
                  },
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
                  onEditingComplete: () {
                    if (widget.tckns.contains(tcknController.text)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Bu müşteri daha önce eklenmiş !"),
                        ),
                      );
                    } else {
                      if (tcknController.text.isNotEmpty &&
                          nameController.text.isNotEmpty &&
                          tcknController.text.length > 10) {
                        dataServices
                            .addCustomer(
                                nameController.text, tcknController.text)
                            .whenComplete(() {
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
                            content:
                                Text("Lütfen bilgileri eksiksiz doldurunuz !"),
                          ),
                        );
                      }
                    }
                  },
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
                if (widget.tckns.contains(tcknController.text)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Bu müşteri daha önce eklenmiş !"),
                    ),
                  );
                } else {
                  if (tcknController.text.isNotEmpty &&
                      nameController.text.isNotEmpty &&
                      tcknController.text.length > 10) {
                    dataServices
                        .addCustomer(nameController.text, tcknController.text)
                        .whenComplete(() {
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
