import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/model/authorized_model.dart';
import 'package:saglamoglu_muhasebe/view/authorized/authorized_view_model.dart';
import 'package:saglamoglu_muhasebe/view/authorized/widgets/authorized_grid_buttons.dart';

class AuthorizedGridWidget extends StatelessWidget {
  const AuthorizedGridWidget({
    super.key,
    required this.dataModel,
    required this.model,
    required this.dataId,
  });

  final AuthorizedModel dataModel;
  final AuthorizedViewModel model;
  final String? dataId;

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          color: Colors.grey.shade200,
        )),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            model.docType(dataModel.doctype.toString()),
            style: pageStyle.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          model.dateFormat(dataModel.seconddate, context),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  dataModel.customername.toString(),
                  style: pageStyle.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  dataModel.customertckn.toString(),
                  style: pageStyle.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(dataModel.authorizedname.toString()),
                Text(dataModel.authorizedtckn.toString(),
                    style: pageStyle.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ),
          AuthorizedGridButtons(
            dataId: dataId,
            dataModel: dataModel,
          ),
        ],
      ),
    );
  }
}
