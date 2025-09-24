import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/model/customer_model.dart';
import 'package:saglamoglu_muhasebe/view/customers/model/customers_view_model.dart';

class CustomerGridButtons extends StatelessWidget {
  const CustomerGridButtons({
    super.key,
    required this.docId,
    required this.customerName,
    required this.dataModel,
    required this.dataIndex,
  });

  final String? docId;
  final String? customerName;
  final CustomerModel dataModel;
  final int dataIndex;

  @override
  Widget build(BuildContext context) {
    final CustomersViewModel model = CustomersViewModel.init;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            model.changeDocWidth(
              MediaQuery.of(context).size.width * 0.4,
              dataModel,
              true,
              dataModel.tcknvkn,
              dataModel.name,
            );
          },
          child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.brown.shade300,
              ),
              child: Icon(Icons.add_chart_rounded)),
        ),
        GestureDetector(
          onTap: () {
            model.changeDocWidth(
              MediaQuery.of(context).size.width * 0.4,
              dataModel,
              false,
              dataModel.tcknvkn,
              dataModel.name,
            );
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.green.shade300,
            ),
            child: Icon(Icons.person_add_alt_1_rounded),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                  onTap: () {
                    if (model.editCustomer.value == false) {
                      model.updateCustomerEditable(dataIndex, dataModel.name,
                          dataModel.tcknvkn, dataModel.telNo);
                    }
                  },
                  child: Icon(Icons.edit_rounded)),
              GestureDetector(
                onTap: () {
                  model.deleteCustomer(docId, customerName, context, dataModel);
                },
                child: Icon(Icons.delete_rounded),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
