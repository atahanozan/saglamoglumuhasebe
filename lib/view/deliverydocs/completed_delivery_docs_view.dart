import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/widget/excel/download_docs_excel.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/delivery_docs_view_model.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/widget/delivery_doc_grid_widget.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/widget/headers.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/widget/list_filters.dart';

class CompletedDeliveryDocsView extends StatelessWidget {
  const CompletedDeliveryDocsView({super.key});

  @override
  Widget build(BuildContext context) {
    final DeliveryDocsViewModel model = DeliveryDocsViewModel.init;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListFilters(
                onFilterComplete: () {
                  model.updateCompleteDataFilterWithSearch(
                      model.searchController.text);
                },
                filterClean: () {
                  model.cleanDataFilter();
                },
              ),
              Headers(
                datePickFunc: () {
                  model.updateDateFilter(context);
                },
                filterEnum: model.filterTypeCompleted.value,
                companyPickFunc: () {},
              ),
              Divider(),
              Flexible(
                child: Obx(
                  () => StreamBuilder(
                    stream: model.deliverCompletedStream(
                      true,
                      model.filterTypeCompleted.value,
                    ),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                          ? CircularProgressIndicator()
                          : ListView.builder(
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> modelData =
                                    snapshot.data!.docs[index].data();
                                DocumentSnapshot snapshotData =
                                    snapshot.data!.docs[index];
                                return DeliveryDocGridWidget(
                                  model: model,
                                  dataModel: model.deliveryController
                                      .snapshotModel(
                                          modelData, snapshotData.id),
                                  docId: snapshotData.id,
                                );
                              },
                            );
                    },
                  ),
                ),
              ),
            ],
          ),
          DownloadDocsExcel(
            statu: true,
            isTotal: false,
            secondStatu: false,
          ),
        ],
      ),
    );
  }
}
