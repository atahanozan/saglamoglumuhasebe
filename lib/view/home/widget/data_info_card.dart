import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/core/widget/excel/download_docs_excel.dart';

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
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: CustomThemeColors.customBlack.c50,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Teslim Dosyaları"),
          SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                child: Text(
                  waitingData,
                  style: pageStyle.headlineMedium
                      ?.copyWith(color: Colors.red.shade900),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  completedData,
                  style: pageStyle.headlineMedium
                      ?.copyWith(color: Colors.green.shade900),
                  textAlign: TextAlign.left,
                ),
              ),
              Expanded(
                child: Text(
                  totalData,
                  style: pageStyle.headlineMedium,
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
          SizedBox(height: 20),
          DownloadDocsExcel(
            statu: false,
            isTotal: true,
            secondStatu: true,
          ),
        ],
      ),
    );
  }
}
