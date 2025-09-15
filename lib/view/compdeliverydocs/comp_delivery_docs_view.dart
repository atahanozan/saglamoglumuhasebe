import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/enums/delivery_doc_stream_filter_enums.dart';
import 'package:saglamoglu_muhasebe/core/widgets/excel/download_docs_excel.dart';
import 'package:saglamoglu_muhasebe/view/compdeliverydocs/model/comp_delivery_docs_view_model.dart';
import 'package:saglamoglu_muhasebe/view/compdeliverydocs/widgets/comp_all_filters.dart';
import 'package:saglamoglu_muhasebe/view/compdeliverydocs/widgets/comp_delivery_doc_grid.dart';
import 'package:saglamoglu_muhasebe/view/compdeliverydocs/widgets/comp_headers.dart';
import 'package:saglamoglu_muhasebe/view/compdeliverydocs/widgets/comp_list_filters.dart';

class CompDeliveryDocsView extends StatelessWidget {
  const CompDeliveryDocsView({super.key});

  @override
  Widget build(BuildContext context) {
    final CompDeliveryDocsViewModel model = CompDeliveryDocsViewModel.instance;
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              CompListFilters(
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
                () => CompAllFilters(
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
              CompHeaders(),
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
                                return CompDeliveryDocGrid(
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
