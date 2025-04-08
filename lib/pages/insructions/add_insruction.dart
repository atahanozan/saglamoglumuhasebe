import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:saglamoglu_muhasebe/helper/utils/lists.dart';
import 'package:saglamoglu_muhasebe/helper/utils/texts.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/custom_dropdown.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/textfield_line.dart';
import 'package:saglamoglu_muhasebe/pages/insructions/money_transfer.dart';

class AddInsruction extends StatefulWidget {
  const AddInsruction({super.key});

  @override
  State<AddInsruction> createState() => _AddInsructionState();
}

class _AddInsructionState extends State<AddInsruction> {
  String btnCompaniesValue = "---";
  String btnBanksValue = "---";
  String firebaseBankName = "---";
  String btnCurrencyValue = "TL";
  String companyIban = "";
  String name = "";
  String iban = "";
  String price = "";
  String comment = "";
  bool visibility = false;
  bool addComment = false;
  final TextEditingController priceController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ibanController = TextEditingController();
  final TextEditingController commentController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    priceController.dispose();
    nameController.dispose();
    ibanController.dispose();
    commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Talimat Ekle"),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Para Transferi",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            TextfieldLine(
              controller: priceController,
              header: "Firma",
              onChangeValue: (i) {},
              textField: CustomDropdown(
                btnValue: btnCompaniesValue,
                onchangeFun: (value) {
                  setState(() {
                    btnCompaniesValue = value.toString();
                    visibility = true;
                  });
                },
                valueList: ListsUtilities.companies(),
              ),
            ),
            Flexible(
              child: Visibility(
                visible: visibility,
                child: StreamBuilder(
                  stream: _firestore
                      .collection("companies")
                      .where("name", isEqualTo: btnCompaniesValue)
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? const CircularProgressIndicator()
                        : ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data =
                                  snapshot.data!.docs[index];

                              return MoneyTransfer(
                                banks: data["banks"],
                                currency: ListsUtilities.currency(),
                                bankValue: btnBanksValue,
                                currencyValue: btnCurrencyValue,
                                bankBranch: data["banksInfos"]
                                    [Texts.bankName(btnBanksValue)]["branch"],
                                companyIban: data["banksInfos"]
                                        [Texts.bankName(btnBanksValue)]
                                    [btnCurrencyValue],
                                price: price,
                                iban: iban,
                                name: name,
                                comment: comment,
                                onBankChange: (vaule) {
                                  setState(() {
                                    btnBanksValue = vaule.toString();
                                  });
                                },
                                onCurrencyChange: (vaule) {
                                  setState(() {
                                    btnCurrencyValue = vaule.toString();
                                  });
                                },
                                priceController: priceController,
                                nameController: nameController,
                                ibanController: ibanController,
                                commentController: commentController,
                                authorized: data["authorized"],
                                addPage: () {
                                  setState(() {
                                    comment = addComment
                                        ? "${commentController.text} açıklaması ile"
                                        : "";
                                    name = nameController.text;
                                    iban = "TR${ibanController.text}";
                                    price = priceController.text;
                                  });
                                },
                                moneyFormat: MaskTextInputFormatter(
                                  mask: '###.###.###.###.###',
                                  filter: {'#': RegExp(r'[0-9]')},
                                ),
                                addComment: addComment,
                                commentBtn: () {
                                  setState(() {
                                    addComment = !addComment;
                                  });
                                },
                              );
                            },
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
