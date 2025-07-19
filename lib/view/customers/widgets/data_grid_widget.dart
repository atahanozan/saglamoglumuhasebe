import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/extensions/uppercase_text_formatter.dart';
import 'package:saglamoglu_muhasebe/core/model/customer_model.dart';
import 'package:saglamoglu_muhasebe/core/widgets/custom_formfield_widget.dart';
import 'package:saglamoglu_muhasebe/view/customers/customers_view_model.dart';
import 'package:saglamoglu_muhasebe/view/customers/widgets/customer_edit_buttons.dart';
import 'package:saglamoglu_muhasebe/view/customers/widgets/customer_grid_buttons.dart';

class DataGridWidget extends StatelessWidget {
  const DataGridWidget({
    super.key,
    required this.dataModel,
    required this.dataIndex,
    required this.dataId,
  });

  final CustomerModel dataModel;
  final int dataIndex;
  final String? dataId;

  @override
  Widget build(BuildContext context) {
    final CustomersViewModel model = CustomersViewModel.init;
    return Obx(() => Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.grey.shade100,
            ),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                model.customerStatuIcon(dataModel.tcknvkn.toString()),
                const SizedBox(width: 8),
                Expanded(child: model.dateFormat(dataModel.date, context)),
                const SizedBox(width: 8),
                Expanded(
                    child: model.editCustomer.value &&
                            model.editCustomerIndex.value == dataIndex
                        ? CustomFormfieldWidget(
                            formName: "",
                            inputFormatter: [],
                            controller: model.editTcknController)
                        : Text(dataModel.tcknvkn.toString())),
                const SizedBox(width: 8),
                Expanded(
                    child: model.editCustomer.value &&
                            model.editCustomerIndex.value == dataIndex
                        ? CustomFormfieldWidget(
                            formName: "",
                            inputFormatter: [
                              UppercaseTextFormatter(),
                            ],
                            controller: model.editNameController)
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${dataModel.name}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "${dataModel.agentName} ${dataModel.agentLastname}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          )),
                const SizedBox(width: 8),
                Expanded(
                    child: model.editCustomer.value &&
                            model.editCustomerIndex.value == dataIndex
                        ? CustomFormfieldWidget(
                            formName: "",
                            inputFormatter: [],
                            controller: model.editTelNoController)
                        : Text(dataModel.telNo.toString())),
                const SizedBox(width: 8),
                Expanded(
                  child: model.editCustomer.value &&
                          model.editCustomerIndex.value == dataIndex
                      ? CustomerEditButtons(
                          dataId: dataId,
                        )
                      : CustomerGridButtons(
                          docId: dataModel.docId,
                          customerName: dataModel.name,
                          dataModel: dataModel,
                          dataIndex: dataIndex,
                        ),
                ),
              ],
            ),
          ],
        )));
  }
}
