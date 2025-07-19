import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/view/customers/customers_view_model.dart';

class CustomerEditButtons extends StatelessWidget {
  const CustomerEditButtons({super.key, required this.dataId});

  final String? dataId;

  @override
  Widget build(BuildContext context) {
    final CustomersViewModel model = CustomersViewModel.init;
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            model.updateCustomerData(dataId);
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
