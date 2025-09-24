import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/model/doc_models.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/compdeliverydocs/model/comp_delivery_docs_view_model.dart';

class CompGridButtons extends StatelessWidget {
  const CompGridButtons(
      {super.key, required this.docId, required this.dataModel});

  final String? docId;
  final DeliveryDocModel dataModel;

  @override
  Widget build(BuildContext context) {
    final CompDeliveryDocsViewModel model = CompDeliveryDocsViewModel.instance;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                  onTap: () {
                    model.saveDeliveryDoc(
                      dataModel.name.toString(),
                      dataModel.tcknvkn.toString(),
                      dataModel.company.toString(),
                      dataModel.price.toString(),
                      dataModel.currency.toString(),
                      context,
                      DateTime.parse(
                        dataModel.date.toString(),
                      ),
                    );
                  },
                  child: Icon(Icons.save_rounded)),
              InkWell(
                  onTap: () {
                    model.printDeliveryDoc(
                      dataModel.name.toString(),
                      dataModel.tcknvkn.toString(),
                      dataModel.company.toString(),
                      dataModel.price.toString(),
                      dataModel.currency.toString(),
                      context,
                      DateTime.parse(
                        dataModel.date.toString(),
                      ),
                    );
                  },
                  child: Icon(Icons.print_rounded)),
              Visibility(
                visible: model.userInfo.value.admin == true ? true : false,
                child: InkWell(
                    onTap: () {
                      model.deleteDeliveryDoc(
                        docId,
                        context,
                        dataModel.name.toString(),
                        dataModel.price.toString(),
                      );
                    },
                    child: Icon(Icons.delete_rounded)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
