import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/widgets/error_box.dart';
import 'package:saglamoglu_muhasebe/view/customers/model/customers_view_model.dart';
import 'package:saglamoglu_muhasebe/view/customers/widgets/add_delivery_doc.dart';
import 'package:saglamoglu_muhasebe/view/customers/widgets/customer_grid_headers.dart';
import 'package:saglamoglu_muhasebe/view/customers/widgets/customer_list_filters.dart';
import 'package:saglamoglu_muhasebe/view/customers/widgets/data_grid_widget.dart';

class CustomersView extends StatelessWidget {
  const CustomersView({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomersViewModel model = CustomersViewModel.init;
    return Scaffold(
      body: Stack(
        alignment: Alignment.centerRight,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomerListFilters(),
              SizedBox(height: 22),
              CustomerGridHeaders(),
              const Divider(),
              Flexible(
                child: Obx(
                  () => StreamBuilder(
                    stream: model.dataStream(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? CircularProgressIndicator()
                          : ListView.builder(
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index) {
                                var dataIndex =
                                    snapshot.data!.docs[index].data();
                                DocumentSnapshot snapshotData =
                                    snapshot.data!.docs[index];

                                return model.customerController
                                            .customerStreamData(
                                                dataIndex, snapshotData.id)
                                            .customerStatu ==
                                        "D"
                                    ? SizedBox()
                                    : DataGridWidget(
                                        dataModel: model.customerController
                                            .customerStreamData(
                                                dataIndex, snapshotData.id),
                                        dataIndex: index,
                                        dataId: snapshotData.id,
                                      );
                              },
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
          AddCustomerInfoDoc(),
          Obx(
            () => ErrorBox(
              boxVisibility: model.errShow.value,
              content: "Lütfen bilgileri eksiksiz doldurunuz",
              closeBox: () {
                model.closeErrorBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
