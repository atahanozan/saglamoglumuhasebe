// import 'package:universal_html/html.dart' as web;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/model/doc_models.dart';
import 'package:saglamoglu_muhasebe/core/widgets/excel/excel_controller.dart';

class DownloadDocsExcel extends StatelessWidget {
  const DownloadDocsExcel({
    super.key,
    required this.dataStatu,
    required this.isTotal,
    required this.docList,
  });

  final bool isTotal;
  final bool dataStatu;
  final Future<List<DeliveryDocModel>> docList;

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
          if (isTotal) {
            showDialog(
                context: context,
                builder: (_) {
                  return Obx(
                    () => AlertDialog(
                      title: Text("Dosya durumu"),
                      content: Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      excelController.dataStatu.value == false
                                          ? Colors.amber
                                          : Colors.transparent),
                              onPressed: () {
                                excelController.changeStatu(false);
                              },
                              child: Text("Tamamlanmadı"),
                            ),
                          ),
                          SizedBox(width: 18),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      excelController.dataStatu.value == true
                                          ? Colors.amber
                                          : Colors.transparent),
                              onPressed: () {
                                excelController.changeStatu(true);
                              },
                              child: Text("Tamamlandı"),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("İptal"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            excelController.saveExcel(
                                excelController.dataStatu.value, docList);
                            Navigator.pop(context);
                          },
                          child: Text("İndir"),
                        ),
                      ],
                    ),
                  );
                });
          } else {
            excelController.saveExcel(dataStatu, docList);
          }
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
