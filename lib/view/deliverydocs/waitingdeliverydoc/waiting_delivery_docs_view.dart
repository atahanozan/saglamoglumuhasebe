import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  model.searchDeliverDoc(model.docStatuInfo.value, "name",
                      model.searchController.text);
                },
                filterClean: () {
                  model.cleanDataFilter(model.docStatuInfo.value);
                },
              ),
              Obx(
                () => AllFiltersWidget(
                  datePickFunc: () async {
                    await model.setFilterDate(
                        context, model.filteredDate.value);
                    if (!model.docStatuInfo.value) {
                      model.searchDeliverDoc(
                        model.docStatuInfo.value,
                        "date",
                        model.filteredDate.value.toString().split(" ")[0],
                      );
                    } else {
                      model.searchDeliverDoc(
                        model.docStatuInfo.value,
                        "lastEditedDate",
                        model.filteredDate.value.toString().split(" ")[0],
                      );
                    }
                  },
                  btnDate: model.filteredDate.value.toString().split(" ")[0],
                  valueName: model.companyFilter.value,
                  saglamFunc: () {
                    model.changeCompanyFilter("Sağlam");
                    model.filterDeliveryDoc(
                      model.docStatuInfo.value,
                      "company",
                      "Sağlam",
                    );
                  },
                  elminaFunc: () {
                    model.changeCompanyFilter("Elmina");
                    model.filterDeliveryDoc(
                      model.docStatuInfo.value,
                      "company",
                      "Elmina",
                    );
                  },
                  saglamKiymetliFunc: () {
                    model.changeCompanyFilter("Sağlam Kıymetli");
                    model.filterDeliveryDoc(
                      model.docStatuInfo.value,
                      "company",
                      "Sağlam Kıymetli",
                    );
                  },
                  controller: model.priceController,
                  clearFilter: () {
                    model.cleanDataFilter(model.docStatuInfo.value);
                  },
                  openfilterTab: () {
                    model.changeFilterTabStatu();
                  },
                  filterTabStatu: model.filterTabStatu.value,
                  priceFilterFunc: () {
                    model.searchDeliverDoc(model.docStatuInfo.value, "price",
                        model.priceController.text);
                  },
                  model: model,
                ),
              ),
              Headers(),
              Divider(),
              Flexible(
                child: Obx(
                  () => StreamBuilder(
                    stream: model.deliveryStream.value,
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
                  model.docStatuInfo.value),
            );
          })
        ],
      ),
    );
  }
}
