import 'package:flutter/material.dart';
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
          height: 400,
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
                  Text("Başlangıç Tarihi:"),
                  SizedBox(width: 6),
                  OutlinedButton(
                      onPressed: () async {
                        await model.pickStartDate(
                            context,
                            model.tesDocFilterStartDate.value,
                            model.tesDocFilterEndDateDate.value);
                        model.updateKycStatuCounts(
                          model.tesDocFilterStartDate.value,
                          model.tesDocFilterEndDateDate.value,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: Text(model.tesDocFilterStartDate.value
                          .toString()
                          .split(" ")[0])),
                  SizedBox(width: 12),
                  Text("Bitiş Tarihi:"),
                  SizedBox(width: 6),
                  OutlinedButton(
                      onPressed: () async {
                        await model.pickEndDate(
                            context,
                            model.tesDocFilterStartDate.value,
                            model.tesDocFilterEndDateDate.value);
                        model.updateKycStatuCounts(
                          model.tesDocFilterStartDate.value,
                          model.tesDocFilterEndDateDate.value,
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: Text(model.tesDocFilterEndDateDate.value
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
        SizedBox(height: 28),
        Row(
          children: [
            Expanded(child: Text("Süreç Başlatıldı:")),
            Expanded(
                child: Text(
              firstValue,
              style: pageStyle.titleLarge,
            )),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: Text("İmza Alındı:")),
            Expanded(
                child: Text(
              secondValue,
              style: pageStyle.titleLarge,
            )),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: Text("Süreç Tamamlandı:")),
            Expanded(
                child: Text(
              thirdValue,
              style: pageStyle.titleLarge,
            )),
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
                child: Text(
              "Toplam Talep:",
              style: pageStyle.titleLarge,
            )),
            Expanded(
                child: Text(
              totalCount,
              style:
                  pageStyle.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            )),
          ],
        ),
      ],
    );
  }
}
