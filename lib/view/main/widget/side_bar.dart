import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/view/main/main_view_model.dart';
import 'package:saglamoglu_muhasebe/view/main/widget/side_bar_buttons.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final MainViewModel model = MainViewModel.init;
    return Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        decoration: BoxDecoration(
          color: CustomThemeColors.customBlack,
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              "assets/images/saglamoglu_logo.svg",
              colorFilter: const ColorFilter.mode(
                CustomThemeColors.customYellow,
                BlendMode.srcIn,
              ),
            ),
            Text(
              "Sürüm: 18",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: CustomThemeColors.customYellow,
                  ),
            ),
            const SizedBox(height: 50),
            Flexible(child: SideBarButtons()),
            TextButton(
              onPressed: () {
                model.userLogout(context);
              },
              child: Text(
                "Çıkış",
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.amber),
              ),
            ),
          ],
        ));
  }
}
