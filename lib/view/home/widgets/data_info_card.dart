import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/core/widgets/excel/download_docs_excel.dart';

class DataInfoCard extends StatelessWidget {
  const DataInfoCard({
    super.key,
    required this.waitingData,
    required this.completedData,
    required this.totalData,
  });

  final String waitingData;
  final String completedData;
  final String totalData;

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    return Container(
      height: 400,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: CustomThemeColors.customBlack.c50,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Teslim Dosyaları Son Durum",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Spacer(),
          Row(
            children: [
              Expanded(
                child: Text(
                  waitingData,
                  style: pageStyle.headlineLarge
                      ?.copyWith(color: Colors.red.shade900),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  completedData,
                  style: pageStyle.headlineLarge
                      ?.copyWith(color: Colors.green.shade900),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  totalData,
                  style: pageStyle.headlineLarge,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Bekleyen",
                  style: pageStyle.bodySmall,
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  "Tamamlanan",
                  style: pageStyle.bodySmall,
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  "Toplam",
                  style: pageStyle.bodySmall,
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          Spacer(),
          DownloadDocsExcel(
            dataStatu: true,
            isTotal: true,
          ),
        ],
      ),
    );
  }
}
