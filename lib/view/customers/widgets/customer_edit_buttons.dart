import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/model/customer_model.dart';
import 'package:saglamoglu_muhasebe/view/customers/model/customers_view_model.dart';

class CustomerEditButtons extends StatelessWidget {
  const CustomerEditButtons({
    super.key,
    required this.dataId,
    required this.dataModel,
  });

  final String? dataId;
  final CustomerModel dataModel;

  @override
  Widget build(BuildContext context) {
    final CustomersViewModel model = CustomersViewModel.init;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            model.updateCustomerData(
              dataId,
              dataModel,
            );
          },
          child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
              child: Icon(Icons.done_rounded)),
        ),
        SizedBox(
          width: 8,
        ),
        GestureDetector(
          onTap: () {
            model.updateCustomerEditable(0, "", "", "");
          },
          child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey,
              ),
              child: Icon(Icons.close_rounded)),
        ),
      ],
    );
  }
}
