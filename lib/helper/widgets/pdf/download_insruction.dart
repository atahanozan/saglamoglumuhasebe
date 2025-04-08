// ignore: deprecated_member_use, avoid_web_libraries_in_flutter
import 'dart:html' as web;

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:saglamoglu_muhasebe/helper/custom_widget.dart';

class DownloadInsruction {
  Future<void> downloadInsruction(
    BuildContext context,
    String bank,
    String bankBranch,
    String content,
    String authorized,
    String date,
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
          pw.Container(
            margin: const pw.EdgeInsets.only(bottom: 30),
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              date,
              style: pw.TextStyle(
                fontSize: 12,
                font: font,
              ),
            ),
          ),
          pw.Text(
            bank,
            style: pw.TextStyle(
              fontSize: 12,
              font: font,
            ),
          ),
          pw.Text(
            bankBranch,
            style: pw.TextStyle(
              fontSize: 12,
              font: font,
            ),
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            content,
            style: pw.TextStyle(
              fontSize: 12,
              font: font,
            ),
          ),
          pw.Container(
            margin: const pw.EdgeInsets.only(top: 30),
            alignment: pw.Alignment.centerRight,
            child: pw.Text(
              authorized,
              style: pw.TextStyle(
                font: font,
                fontSize: 12,
              ),
            ),
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
      ..download = '$bank.pdf';
    web.document.body!.children.add(anchor);
    anchor.click();

    if (!context.mounted) return;
    customWidgets.customSnackBar(
      context,
      "$bank.pdf Dosyası İndirildi.",
    );
  }
}
