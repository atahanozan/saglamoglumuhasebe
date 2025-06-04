// ignore: deprecated_member_use
import 'dart:html' as web;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/models/delivery_docs_data.dart';

class DownloadDocsExcel extends StatefulWidget {
  const DownloadDocsExcel({super.key, required this.statu});

  final bool statu;

  @override
  State<DownloadDocsExcel> createState() => _DownloadDocsExcelState();
}

class _DownloadDocsExcelState extends State<DownloadDocsExcel> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<DeliveryDocsData> allData = [];

  Future<void> fetchData(bool statu) async {
    try {
      final snapshot = await firestore
          .collection("deliverydocs")
          .where("statu", isEqualTo: statu)
          .get();

      setState(() {
        allData = snapshot.docs
            .map((doc) => DeliveryDocsData.fromDocument(doc.data()))
            .toList();
      });
    } catch (e) {
      print("hata: $e");
    }
  }

  Future<void> exportExcel() async {
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Sheet1'];

    List<String> headers = [
      "Tarih",
      "Müşteri Adı",
      "Firma",
      "Tutar",
      "İlgili",
      "Son Değiştirilme"
    ];

    for (var i = 0; i < headers.length; i++) {
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .value = TextCellValue(headers[i]);
    }

    for (var i = 0; i < allData.length; i++) {
      DeliveryDocsData item = allData[i];

      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = TextCellValue(item.date);
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
          .value = TextCellValue(item.name);
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
          .value = TextCellValue(item.company);
      sheetObject
              .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
              .value =
          IntCellValue(int.parse(item.price.split(",")[0].replaceAll(".", "")));
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
          .value = TextCellValue(item.agentName ?? "");
      sheetObject
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
          .value = TextCellValue(item.lastEditedDate ?? "");
    }

    var savedFile = excel.save(fileName: "Bekleyen Teslimler.xlsx");

    // final blob = web.Blob([savedFile], 'application/xlsx');
    // final url = web.Url.createObjectUrlFromBlob(blob);
    // final anchor = web.document.createElement('a') as web.AnchorElement
    //   ..href = url
    //   ..style.display = 'none'
    //   ..download = 'Bekleyen Teslimler.xlsx';
    // web.document.body!.children.add(anchor);
  }

  @override
  void initState() {
    fetchData(widget.statu);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        onPressed: () {
          exportExcel();
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
