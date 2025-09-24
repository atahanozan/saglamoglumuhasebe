import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/enums/delivery_doc_stream_filter_enums.dart';
import 'package:saglamoglu_muhasebe/core/widgets/excel/download_docs_excel.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/waitingdeliverydoc/model/delivery_docs_view_model.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/waitingdeliverydoc/widgets/all_filters_widget.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/waitingdeliverydoc/widgets/delivery_doc_grid_widget.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/waitingdeliverydoc/widgets/headers.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/waitingdeliverydoc/widgets/list_filters.dart';

class WaitingDeliveryDocsView extends StatelessWidget {
  const WaitingDeliveryDocsView({super.key});

  @override
  Widget build(BuildContext context) {
    final DeliveryDocsViewModel model = DeliveryDocsViewModel.instance;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              ListFilters(
                onFilterComplete: () {
                  model.setDeliveryDocStream(
                      newCompanyFilter: model.companyFilter.value,
                      newDateFilter: model.dateFilter.value,
                      newIsDated: model.isDated.value,
                      filterEnum: DeliveryDocStreamFilterEnums.search,
                      newSearchFilter: model.searchController.text);
                },
                filterClean: () {
                  model.cleanDataFilter();
                },
              ),
              Obx(
                () => AllFiltersWidget(
                  datePickFunc: () {
                    model.updateDataFilterWithDate(context);
                  },
                  btnDate: model.dateFilter.value,
                  valueName: model.companyFilter.value,
                  saglamFunc: () {
                    model.setDeliveryDocStream(
                      newCompanyFilter: "Sağlam",
                      newDateFilter: model.dateFilter.value,
                      newIsDated: model.isDated.value,
                    );
                  },
                  elminaFunc: () {
                    model.setDeliveryDocStream(
                      newCompanyFilter: "Elmina",
                      newDateFilter: model.dateFilter.value,
                      newIsDated: model.isDated.value,
                    );
                  },
                  saglamKiymetliFunc: () {
                    model.setDeliveryDocStream(
                      newCompanyFilter: "Sağlam Kıymetli",
                      newDateFilter: model.dateFilter.value,
                      newIsDated: model.isDated.value,
                    );
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
                    model.setDeliveryDocStream(
                        newCompanyFilter: model.companyFilter.value,
                        newDateFilter: model.dateFilter.value,
                        newIsDated: model.isDated.value,
                        filterEnum: DeliveryDocStreamFilterEnums.price,
                        newPriceFilter: model.priceController.text);
                  },
                ),
              ),
              Headers(),
              Divider(),
              Flexible(
                child: Obx(
                  () => StreamBuilder(
                    stream: model.deliveryStream.value.limit(20).snapshots(),
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
          Obx(() {
            return DownloadDocsExcel(
              dataStatu: false,
              isTotal: false,
              docList: model.deliverDocsFilteryExcelFilteredData(
                  model.deliveryStream.value),
            );
          })
        ],
      ),
    );
  }
}
