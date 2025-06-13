import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:saglamoglu_muhasebe/view/home/home_view_model.dart';
import 'package:saglamoglu_muhasebe/view/home/widget/data_info_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewModel model = HomeViewModel.init;

    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            Text(
              "Hoş geldin ${model.userInfo.value.name}",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            SizedBox(height: 25),
            DataInfoCard(
              waitingData: model.waitingDeliveryDocCount.toString(),
              completedData: model.copmleteDeliveryDocCount.toString(),
              totalData: model.totalDeliveryDocCount.toString(),
            ),
          ],
        ),
      ),
    );
  }
}
