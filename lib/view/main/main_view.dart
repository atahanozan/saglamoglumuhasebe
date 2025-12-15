import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:saglamoglu_muhasebe/view/home/model/home_view_model.dart';
import 'package:saglamoglu_muhasebe/view/main/model/main_view_model.dart';
import 'package:saglamoglu_muhasebe/view/main/widgets/add_customer_widget.dart';
import 'package:saglamoglu_muhasebe/view/main/widgets/add_user_button.dart';
import 'package:saglamoglu_muhasebe/view/main/widgets/login_again_widget.dart';
import 'package:saglamoglu_muhasebe/view/main/widgets/profile_button.dart';
import 'package:saglamoglu_muhasebe/view/main/widgets/side_bar.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final MainViewModel model = MainViewModel.instance;
    final HomeViewModel homeModel = HomeViewModel.instance;
    return Scaffold(
      body: Obx(
        () => Stack(
          alignment: Alignment.centerRight,
          children: [
            Row(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.height * 0.28,
                  child: SideBar(),
                ),
                VerticalDivider(
                  width: 1,
                ),
                Expanded(
                  flex: 3,
                  child: model.selectedPage(model.selectedNavigationEnum.value),
                ),
              ],
            ),
            Positioned(
              top: 10,
              right: 10,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    child: model.user.thisUser.value.email ==
                            "ozantokdemir@saglamoglugroup.com"
                        ? AddUserButton()
                        : Text(""),
                  ),
                  SizedBox(width: 12),
                  ProfileButton(
                      userName:
                          "${homeModel.userInfo.value.name.toString()} ${homeModel.userInfo.value.lastName.toString()}",
                      logoutFunc: () {
                        model.userLogout(context);
                      }),
                ],
              ),
            ),
            model.userAdmin.value.admin == true
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Visibility(
                        visible: !model.addCustomerVisibility.value,
                        child: Padding(
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
                      ),
                      AddCustomerWidget()
                    ],
                  )
                : SizedBox(),
            model.loginAgain.value == true
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white38,
                      ),
                      child: Center(
                        child: LoginAgainWidget(onButtonPressed: () {
                          model.userLogout(context);
                        }),
                      ),
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
