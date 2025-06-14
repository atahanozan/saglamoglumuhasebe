import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/view/customers/customers_view_model.dart';
import 'package:saglamoglu_muhasebe/view/customers/widget/add_delivery_doc.dart';
import 'package:saglamoglu_muhasebe/view/customers/widget/customer_grid_headers.dart';
import 'package:saglamoglu_muhasebe/view/customers/widget/customer_list_filters.dart';
import 'package:saglamoglu_muhasebe/view/customers/widget/data_grid_widget.dart';

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
                                return DataGridWidget(
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
        ],
      ),
    );
  }
}
