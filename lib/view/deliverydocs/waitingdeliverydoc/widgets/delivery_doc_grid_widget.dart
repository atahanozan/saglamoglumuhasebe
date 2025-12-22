import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/core/model/doc_models.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/waitingdeliverydoc/model/delivery_docs_view_model.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/waitingdeliverydoc/widgets/grid_buttons.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/waitingdeliverydoc/widgets/grid_skeleton.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/waitingdeliverydoc/widgets/signature_button.dart';

class DeliveryDocGridWidget extends StatelessWidget {
  const DeliveryDocGridWidget({
    super.key,
    required this.model,
    required this.dataModel,
    required this.docId,
  });

  final DeliveryDocModel dataModel;
  final DeliveryDocsViewModel model;
  final String? docId;

  @override
  Widget build(BuildContext context) {
    return GridSkeleton(
      border: Border(
          bottom: BorderSide(
        color: Colors.grey.shade200,
      )),
      apps: GridButtons(
        docId: docId,
        dataModel: dataModel,
      ),
      createdDate: Text(
        model.createdDate(dataModel, context),
      ),
      customer: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            dataModel.name.toString(),
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            dataModel.company.toString(),
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
      firstTransaction: SignatureButton(
        waitinFunction: () {
          model.updateDocProccessStatu(docId, true, dataModel, "İmza Bekliyor");
          model.changeNewProccessStat("İmza Bekliyor");
          model.menuController.close();
        },
        doneFunction: () {
          model.updateDocProccessStatu(docId, true, dataModel, "İmzalandı");
          model.changeNewProccessStat("İmzalandı");
          model.menuController.close();
        },
        sendFunction: () {
          model.updateDocProccessStatu(
              docId, true, dataModel, "Merkeze Gönderildi");
          model.changeNewProccessStat("Merkeze Gönderildi");
          model.menuController.close();
        },
        buttonName: model.docProccessStatu(dataModel),
        menuController: model.menuController,
      ),
      lasUpdate: Text(
        model.lastUpdateDate(dataModel, context),
      ),
      lastUser: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(model.agentName(dataModel)),
          IconButton(
              onPressed: () {
                if (dataModel.agents != null) {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Döküman İşlem Geçmişi"),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 600,
                            child: Row(
                              children: [
                                Expanded(child: Text("İşlem Tarihi")),
                                SizedBox(width: 12),
                                Expanded(child: Text("Kullanıcı")),
                                SizedBox(width: 12),
                                Expanded(child: Text("İşlem")),
                              ],
                            ),
                          ),
                          Divider(),
                          SizedBox(
                            width: 600,
                            height: 400,
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: dataModel.agents?.length,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: Text(dataModel.agents!
                                          .elementAt(index)
                                          .toString()
                                          .split("&")[0]
                                          .split(" ")[0]),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(dataModel.agents!
                                          .elementAt(index)
                                          .toString()
                                          .split("&")[1]),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(dataModel.agents!
                                          .elementAt(index)
                                          .toString()
                                          .split("&")[2]),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Tamam"),
                        ),
                      ],
                    ),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Döküman işlem geçmişi bulunmamaktadır."),
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Tamam"),
                        ),
                      ],
                    ),
                  );
                }
              },
              icon: Icon(
                Icons.info_outline,
                size: 18,
                color: Colors.green,
              )),
        ],
      ),
      price: Text(
        "${dataModel.price} ${dataModel.currency}",
        textAlign: TextAlign.right,
        style: GoogleFonts.lexendGiga(),
      ),
      secondTransaction: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: model.docStatuInfo.value == false
              ? Colors.red.shade50
              : Colors.green.shade50,
          foregroundColor: model.docStatuInfo.value == false
              ? Colors.red.shade800
              : Colors.green.shade800,
          side: BorderSide(
              color: model.docStatuInfo.value == false
                  ? Colors.red.shade800
                  : Colors.green.shade800),
        ),
        onPressed: () {
          if (model.appUser.thisUser.value.admin == true) {
            if (model.docStatuInfo.value == false) {
              model.updateDocStatu(
                docId,
                true,
                context,
                DateTime.now().toString().split(" ")[0],
                dataModel,
              );
            } else {
              model.updateDocStatu(
                docId,
                false,
                context,
                DateTime.now().toString().split(" ")[0],
                dataModel,
              );
            }
          }
        },
        child: model.docStatuInfo.value == false
            ? Text("İmzalı Döküman Bekleniyor")
            : Text("Döküman Teslim Alındı"),
      ),
    );
  }
}
