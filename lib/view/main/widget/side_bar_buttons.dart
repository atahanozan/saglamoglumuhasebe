import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/enums/navigation_enums.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/view/main/main_view_model.dart';

class SideBarButtons extends StatelessWidget {
  const SideBarButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final MainViewModel model = MainViewModel.init;
    final TextStyle? unSelected =
        Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: CustomThemeColors.customWhite,
              letterSpacing: 0,
            );
    final TextStyle? selected = Theme.of(context)
        .textTheme
        .titleMedium
        ?.copyWith(color: CustomThemeColors.customWhite);
    return Column(
      children: List.generate(
          model.userAdmin.value.admin == true
              ? model.navigationEnumList.length
              : model.nonAdminEnumList.length, (index) {
        return Obx(() => GestureDetector(
              onTap: () {
                model.changeSelectedPage(
                  index,
                  model.userAdmin.value.admin == true
                      ? model.navigationEnumList.elementAt(index)
                      : model.nonAdminEnumList.elementAt(index),
                );
              },
              child: Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: model.selectedPageIndex.value == index
                          ? CustomThemeColors.customWhite
                          : Colors.transparent,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    model.userAdmin.value.admin == true
                        ? model.navigationEnumList.elementAt(index).displayIcons
                        : model.nonAdminEnumList.elementAt(index).displayIcons,
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      model.userAdmin.value.admin == true
                          ? model.navigationEnumList
                              .elementAt(index)
                              .displayName
                          : model.nonAdminEnumList.elementAt(index).displayName,
                      style: model.selectedPageIndex.value == index
                          ? selected
                          : unSelected,
                    ),
                  ],
                ),
              ),
            ));
      }),
    );
  }
}
