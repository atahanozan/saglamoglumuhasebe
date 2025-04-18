import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintInsruction {
  Future<void> printInsruction(
    BuildContext context,
    String bank,
    String bankBranch,
    String content,
    String authorized,
    String date,
  ) async {
    final pdf = pw.Document();
    final font = await PdfGoogleFonts.poppinsLight();

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

    await Printing.layoutPdf(onLayout: (format) async => pdf.save());
  }
}
