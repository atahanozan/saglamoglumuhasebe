import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:saglamoglu_muhasebe/helper/ui/uppercase_text_formatter.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/custom_dropdown.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/pick_date_widget.dart';

class AddAuthorized extends StatelessWidget {
  const AddAuthorized({
    super.key,
    required this.addAuthVisibility,
    required this.dropDownList,
    required this.drpDownBtnFunc,
    required this.addAuthValue,
    required this.firstDate,
    required this.secondDate,
    required this.pickFirstDate,
    required this.pickSecondDate,
    required this.saveFun,
    required this.tcknController,
    required this.nameController,
    required this.closeFunc,
  });

  final bool addAuthVisibility;
  final List<String> dropDownList;
  final Function(String? value) drpDownBtnFunc;
  final String addAuthValue;
  final String firstDate;
  final String secondDate;
  final VoidCallback pickFirstDate;
  final VoidCallback pickSecondDate;
  final VoidCallback saveFun;
  final VoidCallback closeFunc;
  final TextEditingController tcknController;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    return Visibility(
      visible: addAuthVisibility,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Belge Türü",
                        style: pageStyle.titleMedium,
                      ),
                      SizedBox(width: 30),
                      CustomDropdown(
                        btnValue: addAuthValue,
                        onchangeFun: drpDownBtnFunc,
                        valueList: dropDownList,
                      ),
                      Spacer(),
                      Text(
                        "Başlangıç Tarihi",
                        style: pageStyle.titleMedium,
                      ),
                      SizedBox(width: 30),
                      PickDateWidget(
                        picakedDate: firstDate,
                        pickDateFunc: pickFirstDate,
                      ),
                      Spacer(),
                      Text(
                        "Bitiş Tarihi",
                        style: pageStyle.titleMedium,
                      ),
                      SizedBox(width: 30),
                      PickDateWidget(
                        picakedDate: secondDate,
                        pickDateFunc: pickSecondDate,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: tcknController,
                          inputFormatters: [
                            MaskTextInputFormatter(
                              mask: '###########',
                              filter: {'#': RegExp(r'[0-9]')},
                            ),
                          ],
                          decoration: InputDecoration(
                              hintText: "Yetkili TCKN",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: TextField(
                          controller: nameController,
                          inputFormatters: [UppercaseTextFormatter()],
                          decoration: InputDecoration(
                              hintText: "Yetili İsmi",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 30),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: saveFun,
                  child: Text("Ekle"),
                ),
                SizedBox(height: 20),
                OutlinedButton(
                  onPressed: closeFunc,
                  child: Text("Kapat"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
