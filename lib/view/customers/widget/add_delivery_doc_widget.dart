import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/extensions/money_text_formatter.dart';
import 'package:saglamoglu_muhasebe/core/model/customer_model.dart';
import 'package:saglamoglu_muhasebe/core/widget/custom_dropdown_btn.dart';
import 'package:saglamoglu_muhasebe/core/widget/custom_formfield_widget.dart';
import 'package:saglamoglu_muhasebe/core/widget/date_picker_widget.dart';
import 'package:saglamoglu_muhasebe/view/customers/customers_view_model.dart';

class AddDeliveryDocWidget extends StatelessWidget {
  const AddDeliveryDocWidget({super.key, required this.docVisibility});

  final bool docVisibility;

  @override
  Widget build(BuildContext context) {
    final CustomersViewModel model = CustomersViewModel.init;
    return Obx(() => Visibility(
          visible: docVisibility,
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
                SizedBox(height: 2),
                Text(
                  model.addDocCustomer.value.name.toString(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(height: 28),
                Text("İşlem tarihi"),
                DatePickerWidget(
                  selectDate: () => model.updateDate(context),
                  btnDate: model.initialDate.value.toString().split(" ")[0],
                ),
                SizedBox(height: 18),
                Text("İşlem firması"),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 45),
                            backgroundColor: model.companyName.value == "Sağlam"
                                ? Colors.green.shade300
                                : Colors.black12),
                        onPressed: () {
                          model.changeCompanyName("Sağlam");
                        },
                        child: Text("Sağlam"),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 45),
                            backgroundColor: model.companyName.value == "Elmina"
                                ? Colors.green.shade300
                                : Colors.black12),
                        onPressed: () {
                          model.changeCompanyName("Elmina");
                        },
                        child: Text("Elmina"),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 18),
                Text("İşlem tutarı"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                      child: CustomFormfieldWidget(
                          formName: "",
                          inputFormatter: [
                            MoneyTextFormatter(),
                          ],
                          controller: model.priceController),
                    ),
                    SizedBox(width: 8),
                    CustomDropdownBtn(
                        btnItems: model.currencies,
                        btnOnchanged: (value) {
                          model.updateSelectedCurrency(value);
                        },
                        btnValue: model.selectedCurrency.value),
                  ],
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    model.addDeliveryDoc(model.addDocCustomer.value, context);
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
