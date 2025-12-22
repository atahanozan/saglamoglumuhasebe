import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/extensions/uppercase_text_formatter.dart';
import 'package:saglamoglu_muhasebe/core/model/tesdoc_model.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/core/widgets/search_field.dart';
import 'package:saglamoglu_muhasebe/view/tesdocs/model/tesdoc_view_model.dart';
import 'package:saglamoglu_muhasebe/view/tesdocs/widgets/filter_section.dart';
import 'package:saglamoglu_muhasebe/view/tesdocs/widgets/tesdoc_data_line.dart';

class TesdocView extends StatelessWidget {
  const TesdocView({super.key});

  @override
  Widget build(BuildContext context) {
    final TesdocViewModel model = TesdocViewModel.init;
    return Scaffold(
        body: Obx(
      () => Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          SearchField(
            controller: model.searchContoller,
            onSearchComplete: () {
              model.searchWithValue(model.searchContoller.text);
            },
            cleanFilter: () {
              model.clearSearch();
            },
            formatters: [
              UppercaseTextFormatter(),
            ],
            backColor: CustomThemeColors.customBlack.c800 ?? Colors.transparent,
            padding: EdgeInsets.symmetric(vertical: 18, horizontal: 12),
          ),
          FilterSection(model: model),
          SizedBox(height: 18),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    "Müşteri Bilgileri",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                Expanded(
                  child: Text(
                    "KYC İşlemleri",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Text(
                    "İkametgah İşlemleri",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          SizedBox(height: 18),
          Flexible(
              child: StreamBuilder(
            stream: model.tesStream.value,
            builder: (context, snapshot) {
              return !snapshot.hasData
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context, index) {
                        var snapData = snapshot.data!.docs[index];
                        var data = TesdocModel.fromDocument(snapData.data());

                        return TesdocDataLine(
                          model: data,
                          tesdocDelete: () {
                            model.deleteTesDoc(
                                "${model.appUser.thisUser.value.name} ${model.appUser.thisUser.value.lastName}",
                                data,
                                context);
                          },
                          startOperation: () {
                            if (model.appUser.thisUser.value.admin == true) {
                              model.updateTesDoc({
                                "ikaStatu": "1",
                                "ikaStarterUser":
                                    "${model.appUser.thisUser.value.name} ${model.appUser.thisUser.value.lastName}",
                                "ikaStartDateTime":
                                    Timestamp.fromDate(DateTime.now()),
                              }, context, snapData.id);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Bu işlemi sadece genel merkez yapabilir.")));
                            }
                          },
                          tesSignFunc: () {
                            if (data.tesStatu == "1") {
                              model.updateTesDoc({
                                "tesStatu": "2",
                                "signUser":
                                    "${model.appUser.thisUser.value.name} ${model.appUser.thisUser.value.lastName}",
                                "signDateTime":
                                    Timestamp.fromDate(DateTime.now()),
                              }, context, snapData.id);
                            }
                          },
                          ikaSignFunc: () {
                            if (data.ikaStatu == "1") {
                              model.updateTesDoc({
                                "ikaStatu": "2",
                                "ikaSignUser":
                                    "${model.appUser.thisUser.value.name} ${model.appUser.thisUser.value.lastName}",
                                "ikaSignDateTime":
                                    Timestamp.fromDate(DateTime.now()),
                              }, context, snapData.id);
                            }
                          },
                          tesCheckFunc: () {
                            if (model.appUser.thisUser.value.admin == true) {
                              if (data.tesStatu == "2") {
                                model.updateTesDoc({
                                  "tesStatu": "3",
                                  "checkUser":
                                      "${model.appUser.thisUser.value.name} ${model.appUser.thisUser.value.lastName}",
                                  "checkDateTime":
                                      Timestamp.fromDate(DateTime.now()),
                                }, context, snapData.id);
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Bu işlemi sadece genel merkez yapabilir.")));
                            }
                          },
                          ikaCheckFunc: () {
                            if (model.appUser.thisUser.value.admin == true) {
                              if (data.ikaStatu == "2") {
                                model.updateTesDoc({
                                  "ikaStatu": "3",
                                  "ikaCheckUser":
                                      "${model.appUser.thisUser.value.name} ${model.appUser.thisUser.value.lastName}",
                                  "ikaCheckDateTime":
                                      Timestamp.fromDate(DateTime.now()),
                                }, context, snapData.id);
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      "Bu işlemi sadece genel merkez yapabilir.")));
                            }
                          },
                        );
                      },
                    );
            },
          )),
        ],
      ),
    ));
  }
}
