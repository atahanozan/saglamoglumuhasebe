import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/model/customer_model.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/core/widget/custom_dropdown_btn.dart';
import 'package:saglamoglu_muhasebe/core/widget/custom_formfield_widget.dart';
import 'package:saglamoglu_muhasebe/core/widget/date_picker_widget.dart';
import 'package:saglamoglu_muhasebe/view/customers/customers_view_model.dart';

class AddAuthorizedWidget extends StatelessWidget {
  const AddAuthorizedWidget({super.key, required this.docVisibility});

  final bool docVisibility;

  @override
  Widget build(BuildContext context) {
    final CustomersViewModel model = CustomersViewModel.init;
    return Obx(() => Visibility(
          visible: model.addDocVisibilty.value,
          child: Form(
            key: model.customerFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        model.docType.value,
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        model.changeDocWidth(
                            0.0, CustomerModel(), false, "", "");
                      },
                      icon: Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                Text(
                  model.addDocCustomer.value.name.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 28),
                CustomDropdownBtn(
                    btnItems: model.docTypeList,
                    btnOnchanged: (value) {
                      model.updateSelectedDocType(value);
                    },
                    btnValue: model.docTypeInit.value),
                SizedBox(height: 18),
                Text("İşlem tarihi"),
                Row(
                  children: [
                    Expanded(
                      child: DatePickerWidget(
                        selectDate: () => model.updateDate(context),
                        btnDate:
                            model.initialDate.value.toString().split(" ")[0],
                      ),
                    ),
                    Expanded(
                      child: DatePickerWidget(
                        selectDate: () => model.updateDate(context),
                        btnDate: model.initialDateSecond.value
                            .toString()
                            .split(" ")[0],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                CustomFormfieldWidget(
                    labelColor: CustomThemeColors.customBlack.c800,
                    formName: "Yetki Alan",
                    hint: "TCKN",
                    inputFormatter: [
                      MaskTextInputFormatter(
                        mask: '###########',
                        filter: {'#': RegExp(r'[0-9]')},
                      ),
                    ],
                    controller: model.authorizedTcknController),
                CustomFormfieldWidget(
                    labelColor: CustomThemeColors.customBlack.c800,
                    formName: "",
                    hint: "Ad Soyad",
                    inputFormatter: [],
                    controller: model.authorizedNameController),
                ElevatedButton(
                  onPressed: () {
                    model.addAuthorized(
                      model.customerTckn.value,
                      model.customerName.value,
                    );
                    model.changeDocWidth(0.0, CustomerModel(), false, "", "");
                  },
                  child: Text("Kaydet"),
                ),
              ],
            ),
          ),
        ));
  }
}
