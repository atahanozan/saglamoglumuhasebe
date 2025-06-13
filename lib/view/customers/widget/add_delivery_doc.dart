import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/view/customers/customers_view_model.dart';
import 'package:saglamoglu_muhasebe/view/customers/widget/add_authorized_widget.dart';
import 'package:saglamoglu_muhasebe/view/customers/widget/add_delivery_doc_widget.dart';

class AddCustomerInfoDoc extends StatelessWidget {
  const AddCustomerInfoDoc({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomersViewModel model = CustomersViewModel.init;
    return Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
          height: MediaQuery.of(context).size.height * 0.6,
          width: model.addDocWidth.value,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: model.isDeliveryDoc.value
                ? Colors.brown.shade100
                : Colors.green.shade100,
          ),
          child: model.isDeliveryDoc.value
              ? AddDeliveryDocWidget(
                  docVisibility: model.addDocVisibilty.value,
                )
              : AddAuthorizedWidget(
                  docVisibility: model.addDocVisibilty.value,
                ),
        ));
  }
}
