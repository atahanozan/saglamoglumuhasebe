// ignore: deprecated_member_use
import 'dart:html' as web;

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:saglamoglu_muhasebe/helper/utils/texts.dart';

class CustomerDeliveryDoc {
  String? id = DateTime.now().millisecondsSinceEpoch.toString();
  Future<void> downloadCustomerDeliveryDoc(
    String name,
    String tckn,
    String companyName,
    String price,
    String product,
    String relating,
    BuildContext context,
  ) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.poppinsBold();
    final fontLigth = await PdfGoogleFonts.poppinsLight();
    const String headerColum = Texts.hdrDeliveryDocs;

    var customPadding = const pw.EdgeInsets.all(5);

    DateTime dateNow = DateTime.now();
    String companyLongName =
        companyName == "SAĞLAMOĞLU" ? Texts.cmpSaglam : Texts.cmpElmina;

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisSize: pw.MainAxisSize.min,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      headerColum,
                      style: pw.TextStyle(font: font),
                    ),
                    pw.SizedBox(
                      height: 10,
                    ),
                    pw.Text(
                      "FATURA NO: ",
                      style: pw.TextStyle(font: font),
                      textAlign: pw.TextAlign.left,
                    ),
                  ],
                ),
              ),
              pw.SizedBox(
                height: 10,
              ),
              pw.Container(
                padding: customPadding,
                decoration: const pw.BoxDecoration(
                    border: pw.Border.symmetric(horizontal: pw.BorderSide())),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        "KONU-CİNS\n(HAS ALTIN)/(HAS GÜMÜŞ)",
                        style: pw.TextStyle(font: font),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        padding: customPadding,
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(left: pw.BorderSide())),
                        child: pw.Expanded(
                          child: pw.Text(
                            product,
                            style: pw.TextStyle(font: fontLigth),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: customPadding,
                decoration: const pw.BoxDecoration(
                    border: pw.Border.symmetric(horizontal: pw.BorderSide())),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        "MİKTAR (GR)",
                        style: pw.TextStyle(font: font),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        padding: customPadding,
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(left: pw.BorderSide())),
                        child: pw.Expanded(
                          child: pw.Text(
                            "..............GRAM",
                            style: pw.TextStyle(font: fontLigth),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: customPadding,
                decoration: const pw.BoxDecoration(
                    border: pw.Border.symmetric(horizontal: pw.BorderSide())),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        "TL KARŞILIĞI",
                        style: pw.TextStyle(font: font),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        padding: customPadding,
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(left: pw.BorderSide())),
                        child: pw.Expanded(
                          child: pw.Text(
                            "$price - TL",
                            style: pw.TextStyle(font: fontLigth),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: customPadding,
                decoration: const pw.BoxDecoration(
                    border: pw.Border.symmetric(horizontal: pw.BorderSide())),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        "DÖVİZ KARŞILIĞI",
                        style: pw.TextStyle(font: font),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        padding: customPadding,
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(left: pw.BorderSide())),
                        child: pw.Expanded(
                          child: pw.Text(
                            "YOK",
                            style: pw.TextStyle(font: fontLigth),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: customPadding,
                decoration: const pw.BoxDecoration(
                    border: pw.Border.symmetric(horizontal: pw.BorderSide())),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        "SATICI FİRMA",
                        style: pw.TextStyle(font: font),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        padding: customPadding,
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(left: pw.BorderSide())),
                        child: pw.Expanded(
                          child: pw.Text(
                            companyLongName,
                            style: pw.TextStyle(font: fontLigth),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: customPadding,
                decoration: const pw.BoxDecoration(
                    border: pw.Border.symmetric(horizontal: pw.BorderSide())),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        "ALICI ŞAHIS / FİRMA\n(MÜŞTERİ)",
                        style: pw.TextStyle(font: font),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        padding: customPadding,
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(left: pw.BorderSide())),
                        child: pw.Expanded(
                          child: pw.Text(
                            name,
                            style: pw.TextStyle(font: fontLigth),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: customPadding,
                decoration: const pw.BoxDecoration(
                    border: pw.Border.symmetric(horizontal: pw.BorderSide())),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        "TC KİMLİK NO / VERGİ NO",
                        style: pw.TextStyle(font: font),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        padding: customPadding,
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(left: pw.BorderSide())),
                        child: pw.Expanded(
                          child: pw.Text(
                            tckn,
                            style: pw.TextStyle(font: fontLigth),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: customPadding,
                decoration: const pw.BoxDecoration(
                    border: pw.Border.symmetric(horizontal: pw.BorderSide())),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        "TESLİM YERİ",
                        style: pw.TextStyle(font: font),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        padding: customPadding,
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(left: pw.BorderSide())),
                        child: pw.Expanded(
                          child: pw.Text(
                            companyLongName,
                            style: pw.TextStyle(font: fontLigth),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: customPadding,
                decoration: const pw.BoxDecoration(
                    border: pw.Border.symmetric(horizontal: pw.BorderSide())),
                child: pw.Row(
                  children: [
                    pw.Expanded(
                      child: pw.Text(
                        "TARİH",
                        style: pw.TextStyle(font: font),
                      ),
                    ),
                    pw.Expanded(
                      child: pw.Container(
                        padding: customPadding,
                        decoration: const pw.BoxDecoration(
                            border: pw.Border(left: pw.BorderSide())),
                        child: pw.Expanded(
                          child: pw.Text(
                            "${dateNow.day}.${dateNow.month}.${dateNow.year}",
                            style: pw.TextStyle(font: fontLigth),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 20),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(
                            "MÜŞTERİ FİRMA :",
                            style: pw.TextStyle(
                              font: font,
                              decoration: pw.TextDecoration.underline,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            " FİRMAMIZIN, KENDİ NAM VE HESABINA ÇALIŞTIĞINI BEYAN EDERİZ.",
                            style: pw.TextStyle(font: fontLigth),
                            textAlign: pw.TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Container(
                      child: pw.Text(
                        "İş bu teslim tesellüm belgesi;miktar ve fiyatta mutabık kalarak $companyLongName den satın alınan kıymetli madenin ve kıymetli maden satım belgesinin birlikte  tam ve eksiksiz olarak teslim edildiğini belgelemek adına tanzim edilmiştir.",
                        style: pw.TextStyle(font: fontLigth),
                      ),
                    ),
                    pw.SizedBox(height: 20),
                    pw.Container(
                      padding: customPadding,
                      alignment: pw.Alignment.center,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.start,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(
                            "MAİL ADRESİ :",
                            style: pw.TextStyle(
                              font: font,
                              decoration: pw.TextDecoration.underline,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            " muhasebe@saglamoglualtin.com",
                            style: pw.TextStyle(font: fontLigth),
                            textAlign: pw.TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(
                            "TESLİM EDEN",
                            style: pw.TextStyle(
                              font: font,
                              decoration: pw.TextDecoration.underline,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            "TESLİM ALAN",
                            style: pw.TextStyle(
                              font: font,
                              decoration: pw.TextDecoration.underline,
                            ),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    pw.Container(
                      alignment: pw.Alignment.center,
                      child: pw.Row(
                        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Text(
                            "Ad / Soyad / İmza",
                            style: pw.TextStyle(font: fontLigth),
                            textAlign: pw.TextAlign.center,
                          ),
                          pw.Text(
                            "Ad / Soyad / İmza",
                            style: pw.TextStyle(font: fontLigth),
                            textAlign: pw.TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
    // final directory = await getApplicationDocumentsDirectory();
    // final path =
    //     '${directory.path}/ALTIN GÜMÜŞ Teslim Tesellüm - $companyName - $name - ${dateNow.day}.${dateNow.month}.${dateNow.year}.pdf';
    // final file = File(path);
    // final pdfFile = await file.writeAsBytes(await pdf.save());
    var savedFile = await pdf.save();
    final blob = web.Blob([savedFile], 'application/pdf');
    final url = web.Url.createObjectUrlFromBlob(blob);
    final anchor = web.document.createElement('a') as web.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download =
          'ALTIN GÜMÜŞ Teslim Tesellüm - $companyName - $name - ${dateNow.day}.${dateNow.month}.${dateNow.year}.pdf';
    web.document.body!.children.add(anchor);
    anchor.click();

    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("$name.pdf Dosyası İndirildi.")));
  }
}
