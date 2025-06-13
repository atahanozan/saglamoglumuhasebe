import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:saglamoglu_muhasebe/view/main/main_view_model.dart';
import 'package:saglamoglu_muhasebe/view/main/widget/add_customer_widget.dart';
import 'package:saglamoglu_muhasebe/view/main/widget/side_bar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final MainViewModel model = MainViewModel.init;
    return Scaffold(
      body: Obx(
        () => Stack(
          alignment: Alignment.centerRight,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: SideBar(),
                ),
                Expanded(
                  flex: 3,
                  child: model.selectedPage(model.selectedNavigationEnum.value),
                ),
              ],
            ),
            model.userAdmin.value.admin == true
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(180, 70),
                                textStyle:
                                    Theme.of(context).textTheme.titleMedium),
                            onPressed: () {
                              model.changePageSize(
                                  MediaQuery.of(context).size.width * 0.4);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add_rounded,
                                  size: 45,
                                ),
                                Text("Müşteri Ekle"),
                              ],
                            ),
                          ),
                        ),
                      ),
                      AddCustomerWidget()
                    ],
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
