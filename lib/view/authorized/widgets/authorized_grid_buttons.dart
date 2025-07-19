import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/model/authorized_model.dart';
import 'package:saglamoglu_muhasebe/view/authorized/authorized_view_model.dart';

class AuthorizedGridButtons extends StatelessWidget {
  const AuthorizedGridButtons({
    super.key,
    required this.dataId,
    required this.dataModel,
  });

  final AuthorizedModel dataModel;
  final String? dataId;

  @override
  Widget build(BuildContext context) {
    final AuthorizedViewModel model = AuthorizedViewModel.init;
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.edit_rounded,
          ),
          InkWell(
            onTap: () {
              model.deleteAuthorized(dataId, context, dataModel.customername);
            },
            child: Icon(
              Icons.delete_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
