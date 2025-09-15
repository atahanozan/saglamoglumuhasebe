import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/view/authorized/model/authorized_view_model.dart';
import 'package:saglamoglu_muhasebe/view/authorized/widgets/authorized_grid_widget.dart';
import 'package:saglamoglu_muhasebe/view/authorized/widgets/authorized_headers.dart';
import 'package:saglamoglu_muhasebe/view/authorized/widgets/authorized_list_filter.dart';

class AuthorizedView extends StatelessWidget {
  const AuthorizedView({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthorizedViewModel model = AuthorizedViewModel.init;
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          AuthorizedListFilter(),
          SizedBox(height: 22),
          AuthorizedHeaders(),
          const Divider(),
          Flexible(
            child: Obx(
              () => StreamBuilder(
                stream: model.dataStream(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: model.allDataList.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> dataDetail =
                                snapshot.data!.docs[index].data();

                            DocumentSnapshot snapshotData =
                                snapshot.data!.docs[index];
                            return AuthorizedGridWidget(
                              dataModel: model.authorizedController
                                  .getSingleAuthorizedData(dataDetail),
                              model: model,
                              dataId: snapshotData.id,
                            );
                          },
                        );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
