import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:saglamoglu_muhasebe/helper/custom_widget.dart';
import 'dart:html' as web;

class CustomerInfoFunctions {
  Future<void> downloadCustomerInfo(
    String tckn,
    String name,
    String iban,
    String adress,
    String placeOfBirth,
    String job,
    String phone,
    BuildContext context,
  ) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.poppinsLight();
    final fontHeader = await PdfGoogleFonts.poppinsBold();
    final CustomWidgets customWidgets = CustomWidgets();

    // final frontImage = await networkImage(frontidimg);
    // final backImage = await networkImage(backidimg);
    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Column(children: [
          pw.Text("Müşteri Bilgileri",
              style: pw.TextStyle(font: fontHeader, fontSize: 20)),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 2),
            decoration: const pw.BoxDecoration(
                border:
                    pw.Border.symmetric(horizontal: pw.BorderSide(width: 0.1))),
            child: pw.Row(children: [
              pw.Expanded(
                flex: 1,
                child: pw.Text(
                  "TCKN",
                  style: pw.TextStyle(font: fontHeader, fontSize: 12),
                ),
              ),
              pw.Text(
                ": ",
                style: pw.TextStyle(font: font, fontSize: 12),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  tckn,
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
              ),
            ]),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 2),
            decoration: const pw.BoxDecoration(
                border:
                    pw.Border.symmetric(horizontal: pw.BorderSide(width: 0.1))),
            child: pw.Row(children: [
              pw.Expanded(
                flex: 1,
                child: pw.Text(
                  "AD SOYAD",
                  style: pw.TextStyle(font: fontHeader, fontSize: 12),
                ),
              ),
              pw.Text(
                ": ",
                style: pw.TextStyle(font: font, fontSize: 12),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  name,
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
              ),
            ]),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 2),
            decoration: const pw.BoxDecoration(
                border:
                    pw.Border.symmetric(horizontal: pw.BorderSide(width: 0.1))),
            child: pw.Row(children: [
              pw.Expanded(
                flex: 1,
                child: pw.Text(
                  "IBAN",
                  style: pw.TextStyle(font: fontHeader, fontSize: 12),
                ),
              ),
              pw.Text(
                ": ",
                style: pw.TextStyle(font: font, fontSize: 12),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  iban,
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
              ),
            ]),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 2),
            decoration: const pw.BoxDecoration(
                border:
                    pw.Border.symmetric(horizontal: pw.BorderSide(width: 0.1))),
            child: pw.Row(children: [
              pw.Expanded(
                flex: 1,
                child: pw.Text(
                  "AÇIK ADRES",
                  style: pw.TextStyle(font: fontHeader, fontSize: 12),
                ),
              ),
              pw.Text(
                ": ",
                style: pw.TextStyle(font: font, fontSize: 12),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  adress,
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
              ),
            ]),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 2),
            decoration: const pw.BoxDecoration(
                border:
                    pw.Border.symmetric(horizontal: pw.BorderSide(width: 0.1))),
            child: pw.Row(children: [
              pw.Expanded(
                flex: 1,
                child: pw.Text(
                  "DOĞUM YERİ",
                  style: pw.TextStyle(font: fontHeader, fontSize: 12),
                ),
              ),
              pw.Text(
                ": ",
                style: pw.TextStyle(font: font, fontSize: 12),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  placeOfBirth,
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
              ),
            ]),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 2),
            decoration: const pw.BoxDecoration(
                border:
                    pw.Border.symmetric(horizontal: pw.BorderSide(width: 0.1))),
            child: pw.Row(children: [
              pw.Expanded(
                flex: 1,
                child: pw.Text(
                  "MESLEK",
                  style: pw.TextStyle(font: fontHeader, fontSize: 12),
                ),
              ),
              pw.Text(
                ": ",
                style: pw.TextStyle(font: font, fontSize: 12),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  job,
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
              ),
            ]),
          ),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(vertical: 2),
            decoration: const pw.BoxDecoration(
                border:
                    pw.Border.symmetric(horizontal: pw.BorderSide(width: 0.1))),
            child: pw.Row(children: [
              pw.Expanded(
                flex: 1,
                child: pw.Text(
                  "TELEFON",
                  style: pw.TextStyle(font: fontHeader, fontSize: 12),
                ),
              ),
              pw.Text(
                ": ",
                style: pw.TextStyle(font: font, fontSize: 12),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  phone,
                  style: pw.TextStyle(font: font, fontSize: 12),
                ),
              ),
            ]),
          ),
        ]);
      },
    ));

    var savedFile = await pdf.save();

    final blob = web.Blob([savedFile], 'application/pdf');
    final url = web.Url.createObjectUrlFromBlob(blob);
    final anchor = web.document.createElement('a') as web.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = '$name.pdf';
    web.document.body!.children.add(anchor);
    anchor.click();

    if (!context.mounted) return;
    customWidgets.customSnackBar(
      context,
      "$name.pdf Dosyası İndirildi.",
    );
  }
}
