import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/model/authorized_model.dart';
import 'package:saglamoglu_muhasebe/view/authorized/model/authorized_view_model.dart';
import 'package:saglamoglu_muhasebe/view/authorized/widgets/authorized_grid_buttons.dart';
import 'package:saglamoglu_muhasebe/view/authorized/widgets/authorized_grid_skeleton.dart';

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
    return AuthorizedGridSkeleton(
      style: Text(
        model.docType(dataModel.doctype.toString()),
        style: pageStyle.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      firstDate: model.createdDate(context, dataModel),
      secondDate: model.lastDate(context, dataModel),
      customer: Column(
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
      authorized: Column(
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
      apps: model.appUser.thisUser.value.admin == true
          ? AuthorizedGridButtons(
              dataId: dataId,
              dataModel: dataModel,
            )
          : SizedBox(),
    );
  }
}
