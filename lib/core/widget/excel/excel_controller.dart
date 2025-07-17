import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/model/doc_models.dart';

class ExcelController extends GetxController {
  static bool get isRegistered => GetInstance().isRegistered<ExcelController>();

  static ExcelController get init => Get.put(ExcelController());
  static ExcelController get instance => Get.find<ExcelController>();

  List<String> get headers => [
        "Tarih",
        "Müşteri Adı",
        "Firma",
        "Tutar",
        "İlgili",
        "Son Değiştirilme",
        "Teslim Durumu"
      ];

  String editedDate(String? timeStamp) {
    if (timeStamp == null) {
      return "";
    } else if (timeStamp.startsWith("Time")) {
      var res = int.parse(timeStamp.split("=")[1].split(",")[0]);
      return DateTime.fromMillisecondsSinceEpoch(res * 1000)
          .toString()
          .split(" ")[0];
    } else if (timeStamp == "null") {
      return "";
    } else {
      return timeStamp.toString();
    }
  }

  String statuName(bool statuBool) {
    switch (statuBool) {
      case true:
        return "Tamamlandı";

      case false:
        return "Bekliyor";
    }
  }

  Future<List<DeliveryDocModel>> deliverDocList(bool dataStatu) async {
    var res = await FirebaseFirestore.instance
        .collection("deliverydocs")
        .where("statu", isEqualTo: dataStatu)
        .get();

    var result = res.docs
        .map((docsData) => DeliveryDocModel.fromDocument(docsData.data()))
        .toList();

    return result;
  }

  Future<void> createSheet(
    Excel docExcel,
    List<DeliveryDocModel> docList,
  ) async {
    Sheet sheet = docExcel["Sheet1"];

    for (int i = 0; i < headers.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .value = TextCellValue(headers[i]);
    }

    for (int i = 0; i < docList.length; i++) {
      DeliveryDocModel itemMode = docList[i];

      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
          .value = TextCellValue(itemMode.date.toString());
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
          .value = TextCellValue(itemMode.name.toString());
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
          .value = TextCellValue(itemMode.company.toString());
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
          .value = TextCellValue(itemMode.price.toString());
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
          .value = TextCellValue(itemMode.agentName.toString());
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
          .value = TextCellValue(editedDate(itemMode.lastEditedDate));
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
          .value = TextCellValue(statuName(itemMode.statu ?? false));
    }
  }

  Future<void> saveExcel(bool newDataStatu) async {
    Excel excel = Excel.createExcel();

    var res = await deliverDocList(newDataStatu);

    await createSheet(excel, res);

    excel.save(fileName: "Teslim Dosyaları.xlsx");
  }

  RxBool dataStatu = false.obs;

  void changeStatu(bool newStatu) {
    dataStatu.value = newStatu;
  }
}
