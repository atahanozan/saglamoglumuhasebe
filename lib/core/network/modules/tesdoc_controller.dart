import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/model/tesdoc_model.dart';

class TesdocController {
  final String _basePath = "tesdoccustomers";
  final List<String> _excelHeaders = [
    "Ad Soyad",
    "TCKN / VKN",
    "TelNo",
    "KYC İşlem Durumu",
    "İkametgah İşlem Durumu",
    "Görevli Adı",
    "KYC İşlem Tarihi",
    "KYC İmza Tarihi",
    "KYC İmza Görevlisi",
    "KYC Kontrol Tarihi",
    "KYC Kontrol Görevlisi",
    "İkametgah İşlem Tarihi",
    "İkametgah İmza Tarihi",
    "İkametgah İmza Görevlisi",
    "İkametgah Kontrol Tarihi",
    "İkametgah Kontrol Görevlisi",
  ];

  final List<String> _emailExcelHeaders = [
    "Ad Soyad",
    "TCKN / VKN",
    "TelNo",
    "KYC İşlem Durumu",
    "İkametgah İşlem Durumu",
    "Görevli Adı",
    "KYC İşlem Tarihi",
    "İkametgah İşlem Tarihi",
  ];

  Future<bool> setData(TesdocModel data) async {
    try {
      await FirebaseFirestore.instance
          .collection(_basePath)
          .doc(data.customerTckn)
          .set(data.toJson());
      await FirebaseFirestore.instance
          .collection('deliverycustomers')
          .doc(data.customerUid)
          .update({
        "tesStatu": "1",
      });
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  }

  Future<void> updateData(
      Map<String, dynamic> newData, String? docId, BuildContext context) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Müşteri durumu güncellenecek onaylıyor musunuz?"),
              actions: [
                OutlinedButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("İptal"),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection(_basePath)
                          .doc(docId)
                          .update(newData);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
                    child: Text("Evet"))
              ],
            ));
  }

  Future<void> deleteData(TesdocModel data, BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(
            "${data.customerName} isimli müşteri için açılan talep silinecektir."),
        actions: [
          OutlinedButton(
              onPressed: () => Navigator.pop(context), child: Text("İptal")),
          ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection(_basePath)
                    .doc(data.customerTckn)
                    .delete();
                await FirebaseFirestore.instance
                    .collection("deliverycustomers")
                    .doc(data.customerUid)
                    .update({"tesStatu": "0"});
                if (context.mounted) {
                  Navigator.pop(context);
                }
              },
              child: Text("Sil")),
        ],
      ),
    );
  }

  Future<int?> getDataCount(
    String dataStatuName,
    String dataStatu,
    DateTime startsAt,
    DateTime endsAt,
  ) async {
    var res = await FirebaseFirestore.instance
        .collection("tesdoccustomers")
        .where(dataStatuName, isEqualTo: dataStatu)
        .where("dateTime", isGreaterThan: Timestamp.fromDate(startsAt))
        .where("dateTime", isLessThan: Timestamp.fromDate(endsAt))
        .count()
        .get();

    return res.count;
  }

  Stream tesDocStream(
    int filterStatu,
    String filterName,
    String? filterValue,
  ) {
    switch (filterStatu) {
      case 0:
        var response = FirebaseFirestore.instance
            .collection("tesdoccustomers")
            .where("tesStatu", isNotEqualTo: "3")
            .orderBy("id", descending: true)
            .limit(20)
            .snapshots();

        return response;
      case 1:
        var response = FirebaseFirestore.instance
            .collection("tesdoccustomers")
            .where(filterName, isEqualTo: filterValue)
            .limit(20)
            .snapshots();

        return response;
      case 2:
        var response = FirebaseFirestore.instance
            .collection("tesdoccustomers")
            .where(filterName, isGreaterThanOrEqualTo: filterValue)
            .limit(20)
            .snapshots();

        return response;

      default:
        var response = FirebaseFirestore.instance
            .collection("tesdoccustomers")
            .where("tesStatu", isNotEqualTo: "3")
            .orderBy("id", descending: true)
            .limit(20)
            .snapshots();

        return response;
    }
  }

  Future<List<TesdocModel>> getOldCustomers() async {
    var response = await FirebaseFirestore.instance
        .collection("tesdoccustomers")
        .where("tesStatu", isEqualTo: "1")
        .where("dateTime",
            isLessThan: Timestamp.fromDate(
                DateTime.now().subtract(const Duration(hours: 12))))
        .get();

    var result = response.docs
        .map((item) => TesdocModel.fromDocument(item.data()))
        .toList();

    return result;
  }

  Future<void> saveAsExcelDoc(
    DateTime startsAt,
    DateTime endsAt,
  ) async {
    Excel excel = Excel.createExcel();
    Sheet sheet = excel["Sheet1"];
    var response = await FirebaseFirestore.instance
        .collection("tesdoccustomers")
        .where("dateTime", isGreaterThan: Timestamp.fromDate(startsAt))
        .where("dateTime", isLessThan: Timestamp.fromDate(endsAt))
        .get();

    for (var i = 0; i < _excelHeaders.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .value = TextCellValue(_excelHeaders[i]);
    }

    for (var i = 0; i < response.docs.length; i++) {
      var result = TesdocModel.fromDocument(response.docs[i].data());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = TextCellValue(result.customerName.toString());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
          .value = TextCellValue(result.customerTckn.toString());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
          .value = TextCellValue(result.customerPhone.toString());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
          .value = TextCellValue(result.tesStatuName());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
          .value = TextCellValue(result.ikaStatuName());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
          .value = TextCellValue(result.starterUser.toString());

      sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
              .value =
          result.dateTime != null
              ? DateCellValue.fromDateTime(result.dateTime!.toDate())
              : TextCellValue("");

      sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
              .value =
          result.signDateTime != null
              ? DateCellValue.fromDateTime(result.signDateTime!.toDate())
              : TextCellValue("");

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1))
          .value = TextCellValue(result.signUser.toString());

      sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i + 1))
              .value =
          result.checkDateTime != null
              ? DateCellValue.fromDateTime(result.checkDateTime!.toDate())
              : TextCellValue("");

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i + 1))
          .value = TextCellValue(result.checkUser.toString());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i + 1))
          .value = result.ikaStartDateTime !=
              null
          ? DateCellValue.fromDateTime(result.ikaStartDateTime!.toDate())
          : TextCellValue("");

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i + 1))
          .value = TextCellValue(result.ikaStarterUser.toString());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i + 1))
          .value = result.ikaSignDateTime !=
              null
          ? DateCellValue.fromDateTime(result.ikaSignDateTime!.toDate())
          : TextCellValue("");

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: i + 1))
          .value = TextCellValue(result.ikaSignUser.toString());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 15, rowIndex: i + 1))
          .value = result.ikaCheckDateTime !=
              null
          ? DateCellValue.fromDateTime(result.ikaCheckDateTime!.toDate())
          : TextCellValue("");

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 16, rowIndex: i + 1))
          .value = TextCellValue(result.ikaCheckUser.toString());
    }

    excel.save(fileName: "KYC Durum Raporu.xlsx");
  }

  Future<void> sendEmailWithExcel(
    DateTime startsAt,
    DateTime endsAt,
  ) async {
    Excel excel = Excel.createExcel();
    Sheet sheet = excel["Sheet1"];
    final DateTime now = DateTime.now();
    var response = await FirebaseFirestore.instance
        .collection("tesdoccustomers")
        .where("tesStatu", isEqualTo: "1")
        .where("dateTime",
            isLessThan:
                Timestamp.fromDate(now.subtract(const Duration(hours: 12))))
        .get();

    for (var i = 0; i < _emailExcelHeaders.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .value = TextCellValue(_emailExcelHeaders[i]);
    }

    for (var i = 0; i < response.docs.length; i++) {
      var result = TesdocModel.fromDocument(response.docs[i].data());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = TextCellValue(result.customerName.toString());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
          .value = TextCellValue(result.customerTckn.toString());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
          .value = TextCellValue(result.customerPhone.toString());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
          .value = TextCellValue(result.tesStatuName());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
          .value = TextCellValue(result.ikaStatuName());

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
          .value = TextCellValue(result.starterUser.toString());

      sheet
              .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
              .value =
          result.dateTime != null
              ? DateCellValue.fromDateTime(result.dateTime!.toDate())
              : TextCellValue("");

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i + 1))
          .value = result.ikaStartDateTime !=
              null
          ? DateCellValue.fromDateTime(result.ikaStartDateTime!.toDate())
          : TextCellValue("");
    }

    excel.save(
        fileName:
            "Bekleyen_KYC_islemleri_${now.day}${now.month}${now.year}.xlsx");
  }
}
