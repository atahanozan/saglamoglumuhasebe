import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/custom_dropdown.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/textfield_line.dart';

class MoneyTransfer extends StatelessWidget {
  const MoneyTransfer({
    super.key,
    required this.banks,
    required this.currency,
    required this.bankValue,
    required this.currencyValue,
    required this.bankBranch,
    required this.companyIban,
    required this.price,
    required this.iban,
    required this.name,
    required this.comment,
    required this.onBankChange,
    required this.onCurrencyChange,
    required this.onNameChange,
    required this.onIbanChange,
    required this.onCommentChange,
    required this.priceController,
    required this.nameController,
    required this.ibanController,
    required this.commentController,
    required this.onPriceChange,
  });

  final List<String> banks;
  final List<String> currency;
  final String bankValue;
  final String currencyValue;
  final String bankBranch;
  final String companyIban;
  final String price;
  final String iban;
  final String name;
  final String comment;
  final Function(String? value) onBankChange;
  final Function(String? value) onCurrencyChange;
  final Function(String? value) onNameChange;
  final Function(String? value) onIbanChange;
  final Function(String? value) onCommentChange;
  final Function(String? value) onPriceChange;
  final TextEditingController priceController;
  final TextEditingController nameController;
  final TextEditingController ibanController;
  final TextEditingController commentController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.amber.shade100,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextfieldLine(
                  controller: nameController,
                  header: "Banka",
                  onChangeValue: onBankChange,
                  formatter: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      return newValue.copyWith(
                          text: newValue.text.toUpperCase());
                    })
                  ],
                  textField: CustomDropdown(
                      btnValue: bankValue,
                      onchangeFun: onBankChange,
                      valueList: banks),
                ),
              ),
              Expanded(
                child: TextfieldLine(
                  controller: priceController,
                  header: "Tutar",
                  onChangeValue: onPriceChange,
                  formatter: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  lastWidget: CustomDropdown(
                      btnValue: currencyValue,
                      onchangeFun: onCurrencyChange,
                      valueList: currency),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: TextfieldLine(
                  controller: nameController,
                  header: "Alıcı Adı",
                  onChangeValue: onNameChange,
                  formatter: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      return newValue.copyWith(
                          text: newValue.text.toUpperCase());
                    })
                  ],
                ),
              ),
              Expanded(
                child: TextfieldLine(
                  controller: ibanController,
                  header: "Alıcı Iban",
                  onChangeValue: onIbanChange,
                  formatter: [
                    TextInputFormatter.withFunction((oldValue, newValue) {
                      return newValue.copyWith(
                          text: newValue.text.toUpperCase());
                    })
                  ],
                ),
              ),
            ],
          ),
          TextfieldLine(
            controller: commentController,
            header: "Açıklama",
            onChangeValue: onCommentChange,
            formatter: [
              TextInputFormatter.withFunction((oldValue, newValue) {
                return newValue.copyWith(text: newValue.text.toUpperCase());
              })
            ],
          ),
          Flexible(
            child: Container(
              padding: const EdgeInsets.only(left: 30, top: 20, right: 30),
              margin: const EdgeInsets.all(8),
              alignment: Alignment.topCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(bankValue),
                    const SizedBox(height: 10),
                    Text("$bankBranch Şubesine,"),
                    const SizedBox(height: 35),
                    Text(
                      "Şubenizde bulunan $companyIban nolu $currencyValue hesabımızdan $price $currencyValue'nin, $iban nolu ibana ait, $name'a, $comment açıklaması ile transfer edilmesini rica ederim.",
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
