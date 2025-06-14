// import 'package:universal_html/html.dart' as web;

import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/widget/excel/excel_controller.dart';

class DownloadDocsExcel extends StatelessWidget {
  const DownloadDocsExcel({
    super.key,
    required this.statu,
    required this.secondStatu,
    required this.isTotal,
  });

  final bool statu;
  final bool secondStatu;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    final ExcelController excelController = ExcelController.init;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
      alignment: Alignment.bottomLeft,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green.shade700,
          fixedSize: Size(130, 60),
        ),
        onPressed: () {
          excelController.saveExcel(isTotal, statu, secondStatu);
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.download),
            SizedBox(width: 10),
            Text("Excel"),
          ],
        ),
      ),
    );
  }
}
