import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/widgets/excel/download_docs_excel.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/delivery_docs_view_model.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/widgets/all_filters_widget.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/widgets/delivery_doc_grid_widget.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/widgets/headers.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/widgets/list_filters.dart';

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
            mainAxisAlignment: MainAxisAlignment.start,
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
              Obx(
                () => AllFiltersWidget(
                  datePickFunc: () {
                    model.updateDateFilter(context);
                  },
                  btnDate: model.dateFilter.value,
                  valueName: model.companyFilterGeneral.value,
                  saglamFunc: () {
                    model.updateCompanyFilter("Sağlam");
                  },
                  elminaFunc: () {
                    model.updateCompanyFilter("Elmina");
                  },
                  saglamKiymetliFunc: () {
                    model.updateCompanyFilter("Sağlam Kıymetli");
                  },
                  controller: model.priceController,
                  clearFilter: () {
                    model.cleanDataFilter();
                  },
                  openfilterTab: () {
                    model.changeFilterTabStatu();
                  },
                  filterTabStatu: model.filterTabStatu.value,
                  priceFilterFunc: () {
                    model.updateDataFilterWithPrice(model.priceController.text);
                  },
                ),
              ),
              Headers(),
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
            isTotal: false,
            dataStatu: true,
          ),
        ],
      ),
    );
  }
}
