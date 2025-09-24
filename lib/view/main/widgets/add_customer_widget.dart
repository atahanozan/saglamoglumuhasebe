import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/extensions/uppercase_text_formatter.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/core/widgets/custom_formfield_widget.dart';
import 'package:saglamoglu_muhasebe/view/main/model/main_view_model.dart';

class AddCustomerWidget extends StatelessWidget {
  const AddCustomerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final MainViewModel model = MainViewModel.instance;
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
                // GestureDetector(onTap: () {
                //   model.pickImage();
                // }, child: Obx(() {
                //   return Container(
                //     height: 100,
                //     width: 200,
                //     decoration: BoxDecoration(
                //       image: DecorationImage(
                //           image: model.frontIdImage.value.isEmpty
                //               ? AssetImage("assets/images/front.png")
                //               : FileImage(File(model.frontIdImagePath.value))),
                //     ),
                //   );
                // })),
                CustomFormfieldWidget(
                  isPassword: false,
                  formName: 'TCKN / VKN',
                  isObsecure: false,
                  inputFormatter: [
                    MaskTextInputFormatter(
                      mask: '###########',
                      filter: {'#': RegExp(r'[0-9]')},
                    ),
                  ],
                  controller: model.tcknVknController,
                ),
                CustomFormfieldWidget(
                  isPassword: false,
                  formName: 'Ad Soyad',
                  isObsecure: false,
                  inputFormatter: [
                    UppercaseTextFormatter(),
                  ],
                  controller: model.nameController,
                ),
                CustomFormfieldWidget(
                  isPassword: false,
                  formName: 'Tel No',
                  isObsecure: false,
                  inputFormatter: [
                    MaskTextInputFormatter(
                      mask: '0### ### ## ##',
                      filter: {'#': RegExp(r'[0-9]')},
                    ),
                  ],
                  controller: model.phoneController,
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        model.addCustomer(context);
                      },
                      child: Text("Ekle"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
