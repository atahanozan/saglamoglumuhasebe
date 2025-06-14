import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/extensions/uppercase_text_formatter.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/core/widget/custom_formfield_widget.dart';
import 'package:saglamoglu_muhasebe/view/main/main_view_model.dart';

class AddCustomerWidget extends StatelessWidget {
  const AddCustomerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MainViewModel model = MainViewModel.init;
    return Obx(
      () => AnimatedContainer(
        height: double.infinity,
        width: model.custmerAddPageSize.value,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        duration: const Duration(milliseconds: 500),
        decoration: BoxDecoration(
          color: CustomThemeColors.customBlack.c800,
        ),
        child: Visibility(
          visible: model.addCustomerVisibility.value,
          child: Form(
            key: model.formKey,
            child: Column(
              children: [
                SizedBox(height: 100),
                Row(
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          model.changePageSize(0);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Kapat"),
                            Icon(Icons.close),
                          ],
                        )),
                    Spacer(),
                    Text(
                      "Müşteri Ekle",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(height: 26),
                CustomFormfieldWidget(
                  formName: 'TCKN / VKN',
                  inputFormatter: [
                    MaskTextInputFormatter(
                      mask: '###########',
                      filter: {'#': RegExp(r'[0-9]')},
                    ),
                  ],
                  controller: model.tcknVknController,
                ),
                CustomFormfieldWidget(
                  formName: 'Ad Soyad',
                  inputFormatter: [
                    UppercaseTextFormatter(),
                  ],
                  controller: model.nameController,
                ),
                CustomFormfieldWidget(
                  formName: 'Tel No',
                  inputFormatter: [
                    MaskTextInputFormatter(
                      mask: '0### ### ## ##',
                      filter: {'#': RegExp(r'[0-9]')},
                    ),
                  ],
                  controller: model.phoneController,
                ),
                ElevatedButton(
                  onPressed: () {
                    model.addCustomer();
                  },
                  child: Text("Ekle"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
