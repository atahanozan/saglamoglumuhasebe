import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/helper/utils/lists.dart';
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
  String btnCurrencyValue = "TL";
  String companyIban = "";
  String name = "";
  String iban = "";
  String price = "";
  String comment = "";
  bool visibility = false;
  final TextEditingController priceController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ibanController = TextEditingController();
  final TextEditingController commentController = TextEditingController();

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
                child: MoneyTransfer(
                  banks: ListsUtilities.banks(),
                  currency: ListsUtilities.currency(),
                  bankValue: btnBanksValue,
                  currencyValue: btnCurrencyValue,
                  bankBranch: "bankBranch",
                  companyIban: companyIban,
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
                  onNameChange: (vaule) {
                    setState(() {
                      name = nameController.text;
                    });
                  },
                  onIbanChange: (vaule) {
                    setState(() {
                      iban = "TR${ibanController.text}";
                    });
                  },
                  onCommentChange: (vaule) {
                    setState(() {
                      comment = commentController.text;
                    });
                  },
                  priceController: priceController,
                  nameController: nameController,
                  ibanController: ibanController,
                  commentController: commentController,
                  onPriceChange: (String? value) {
                    setState(() {
                      price = priceController.text;
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Yazdır"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("İndir"),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text("Kaydet"),
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
