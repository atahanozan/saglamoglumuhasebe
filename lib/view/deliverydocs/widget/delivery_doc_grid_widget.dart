import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/core/model/doc_models.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/delivery_docs_view_model.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/widget/grid_buttons.dart';

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
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                  color: Colors.white,
                ),
                left: BorderSide(
                  width: 3,
                  color: model
                      .headerColor(dataModel.proccesstatu, dataModel.statu)
                      .shade900,
                )),
            color: CustomThemeColors.customWhite,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(width: 20),
              model.dateFormat(dataModel.date, context),
              const SizedBox(width: 12),
              Expanded(
                  child: Column(
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
                    "${dataModel.agentName} ${dataModel.agentLastname}",
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              )),
              const SizedBox(width: 5),
              Expanded(child: Text(model.editedDate(dataModel.lastEditedDate))),
              const SizedBox(width: 5),
              Text(
                dataModel.company.toString(),
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.black,
                    ),
              ),
              const SizedBox(width: 5),
              Expanded(
                  child: Text(
                "${dataModel.price} ${dataModel.currency}",
                textAlign: TextAlign.right,
                style: GoogleFonts.lexendGiga(),
              )),
              const SizedBox(width: 5),
              GridButtons(
                docId: docId,
                dataModel: dataModel,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            model.updateDocProccessStatu(
                docId, dataModel.proccesstatu == true ? false : true);
          },
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Icon(
              dataModel.proccesstatu == true
                  ? Icons.check_circle_rounded
                  : Icons.remove_circle_rounded,
              color: dataModel.proccesstatu == true
                  ? Colors.green.shade800
                  : Colors.red.shade800,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
