import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:saglamoglu_muhasebe/view/home/model/home_view_model.dart';
import 'package:saglamoglu_muhasebe/view/home/widgets/data_info_card.dart';
import 'package:saglamoglu_muhasebe/view/home/widgets/data_info_grid.dart';
import 'package:saglamoglu_muhasebe/view/home/widgets/header_line_widget.dart';
import 'package:saglamoglu_muhasebe/view/home/widgets/kyc_info_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel model = HomeViewModel.init;

    return Scaffold(
      body: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderLineWidget(userName: model.userInfo.value.name ?? ""),
            DataInfoGrid(
              firsWidget: DataInfoCard(
                waitingData: model.waitingDeliveryDocCount.toString(),
                completedData: model.copmleteDeliveryDocCount.toString(),
                totalData: model.totalDeliveryDocCount.toString(),
              ),
              secondWidget: KycInfoCard(
                model: model,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
