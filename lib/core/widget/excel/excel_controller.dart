import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/model/doc_models.dart';

class ExcelController extends GetxController {
  static bool get isRegistered => GetInstance().isRegistered<ExcelController>();

  static ExcelController get init => Get.put(ExcelController());
  static ExcelController get instance => Get.find<ExcelController>();

  RxString docName = "Teslimler".obs;
  RxString firstSheetName = "Sheet1".obs;
  RxString secondSheetName = "Sheet2".obs;

  String sheetName(bool statu) {
    switch (statu) {
      case true:
        return "Tamamlanan Teslim";
      case false:
        return "Bekleyen Teslim";
    }
  }

  List<String> get headers => [
        "Tarih",
        "Müşteri Adı",
        "Firma",
        "Tutar",
        "İlgili",
        "Son Değiştirilme",
      ];

  Future<List<DeliveryDocModel>> waitingDeliveryDocsData() async {
    var res = await FirebaseFirestore.instance
        .collection("deliverydocs")
        .where("statu", isEqualTo: false)
        .get();

    var result = res.docs
        .map((docsData) => DeliveryDocModel.fromDocument(docsData.data()))
        .toList();

    return result;
  }

  Future<List<DeliveryDocModel>> completedDeliveryDocsData() async {
    var res = await FirebaseFirestore.instance
        .collection("deliverydocs")
        .where("statu", isEqualTo: true)
        .get();

    var result = res.docs
        .map((docsData) => DeliveryDocModel.fromDocument(docsData.data()))
        .toList();

    return result;
  }

  Future<void> createSheet(
    Excel dataExcel,
    String sheetName,
    List<DeliveryDocModel> item,
  ) async {
    Sheet sheet = dataExcel[sheetName];

    for (int i = 0; i < headers.length; i++) {
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
          .value = TextCellValue(headers[i]);
    }

    for (int i = 0; i < item.length; i++) {
      DeliveryDocModel itemMode = item[i];

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
              .value =
          IntCellValue(int.parse(
              itemMode.price.toString().split(",")[0].replaceAll(".", "")));
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
          .value = TextCellValue(itemMode.agentName ?? "");
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
          .value = TextCellValue(itemMode.lastEditedDate ?? "");
    }
  }

  Future<void> saveExcel(bool isTotal, bool statu, bool secondStatu) async {
    Excel excel = Excel.createExcel();

    var firstData = await waitingDeliveryDocsData();
    var secondData = await completedDeliveryDocsData();

    switch (isTotal) {
      case true:
        {
          await createSheet(
            excel,
            sheetName(statu),
            firstData,
          );
          await createSheet(
            excel,
            sheetName(secondStatu),
            secondData,
          );

          excel.delete("Sheet1");

          excel.save(fileName: "Teslimler.xlsx");
        }
      case false:
        {
          await createSheet(
            excel,
            sheetName(statu),
            statu ? secondData : firstData,
          );
          excel.delete("Sheet1");

          excel.save(fileName: "Teslimler.xlsx");
        }
    }
  }
}
