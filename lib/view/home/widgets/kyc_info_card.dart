import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/view/home/model/home_view_model.dart';

class KycInfoCard extends StatelessWidget {
  const KycInfoCard({super.key, required this.model});

  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          height: 800,
          width: 300,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: CustomThemeColors.customBlack.c50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: model.kycExcelButtonVisibility(
                        model.appUser.thisUser.value.email),
                    child: ElevatedButton(
                      onPressed: () {
                        model.downloadExcelDocKyc(
                          model.tesDocFilterStartDate.value,
                          model.tesDocFilterEndDate.value,
                          context,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffd5edaa)),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            "assets/images/excel.svg",
                            height: 35,
                            width: 35,
                          ),
                          SizedBox(width: 4),
                          Text("Excel"),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    "Başlangıç Tarihi:",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(width: 6),
                  OutlinedButton(
                      onPressed: () async {
                        await model.pickStartDate(
                          context,
                          model.tesDocFilterStartDate.value,
                          model.tesDocFilterEndDate.value,
                        );
                        model.updateKycStatuCounts(
                          model.tesDocFilterStartDate.value,
                          model.tesDocFilterEndDate.value,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: Text(model.tesDocFilterStartDate.value
                          .toString()
                          .split(" ")[0])),
                  SizedBox(width: 12),
                  Text(
                    "Bitiş Tarihi:",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(width: 6),
                  OutlinedButton(
                      onPressed: () async {
                        await model.pickEndDate(
                          context,
                          model.tesDocFilterEndDate.value,
                          model.tesDocFilterStartDate.value,
                        );
                        model.updateKycStatuCounts(
                          model.tesDocFilterStartDate.value,
                          model.tesDocFilterEndDate.value,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: Text(model.tesDocFilterEndDate.value
                          .toString()
                          .split(" ")[0])),
                  SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: () {
                      model.clearKycDateFilter();
                      model.updateKycStatuCounts(
                        DateTime(2025, 12, 16),
                        DateTime.now(),
                      );
                    },
                    child: Text("Temizle"),
                  ),
                ],
              ),
              Divider(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                      child: _dataInfoGrid(
                    "KYC Talep Durumu",
                    (model.kycStart.value +
                            model.kycSign.value +
                            model.kycComplete.value)
                        .toString(),
                    model.kycStart.value.toString(),
                    model.kycSign.value.toString(),
                    model.kycComplete.value.toString(),
                    Theme.of(context).textTheme,
                  )),
                  Expanded(
                      child: _dataInfoGrid(
                    "İkametgah Talep Durumu",
                    (model.ikaStart.value +
                            model.ikaSign.value +
                            model.ikaComplete.value)
                        .toString(),
                    model.ikaStart.value.toString(),
                    model.ikaSign.value.toString(),
                    model.ikaComplete.value.toString(),
                    Theme.of(context).textTheme,
                  )),
                ],
              ),
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: CustomThemeColors.customWhite,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "Uzun Süreli Bekleyen KYC Listesi (${model.appSettings.oldKycCustomers.length})",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Spacer(),
                          OutlinedButton(
                            onPressed: () {
                              model.appSettings.getOldKycCustomers();
                            },
                            child: Text("Yenile"),
                          ),
                        ],
                      ),
                      Divider(
                        height: 30,
                      ),
                      Flexible(
                        child: ListView.builder(
                          itemCount: model.appSettings.oldKycCustomers.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(8),
                              margin: const EdgeInsets.only(bottom: 5),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ListTile(
                                title: Text(model.appSettings
                                    .oldKycCustomers[index].customerName
                                    .toString()),
                                subtitle: Text(model.appSettings
                                    .oldKycCustomers[index].customerTckn
                                    .toString()),
                                leading: Text(model
                                    .appSettings.oldKycCustomers[index]
                                    .finalDate()),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(model.appSettings
                                        .oldKycCustomers[index].customerPhone
                                        .toString()),
                                    SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {
                                        model.updateKycCustomer(
                                          model
                                              .appSettings
                                              .oldKycCustomers[index]
                                              .customerTckn,
                                          context,
                                          "${model.appUser.thisUser.value.name} ${model.appUser.thisUser.value.lastName}",
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: CustomThemeColors
                                              .customYellow.c300),
                                      child: Text("İmza Alındı"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Column _dataInfoGrid(
    String title,
    String totalCount,
    String firstValue,
    String secondValue,
    String thirdValue,
    TextTheme pageStyle,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: pageStyle.titleLarge,
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(child: Text("Süreç Başlatıldı:")),
            Expanded(child: Text(firstValue)),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(child: Text("İmza Alındı:")),
            Expanded(child: Text(secondValue)),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(child: Text("Süreç Tamamlandı:")),
            Expanded(child: Text(thirdValue)),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Expanded(
                child: Text(
              "Toplam Talep:",
              style: pageStyle.titleMedium,
            )),
            Expanded(
                child: Text(
              totalCount,
              style:
                  pageStyle.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ],
    );
  }
}
