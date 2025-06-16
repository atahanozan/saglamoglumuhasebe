import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
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
          color: CustomThemeColors.customBlack.c800,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/images/saglamoglu_logo.svg",
              colorFilter: ColorFilter.mode(
                CustomThemeColors.customYellow.c800 ?? Colors.amber,
                BlendMode.srcIn,
              ),
            ),
            Text(
              "Sürüm: 21",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: CustomThemeColors.customYellow.c800,
                  ),
            ),
            const SizedBox(height: 50),
            Flexible(child: SideBarButtons()),
            Divider(
              color: CustomThemeColors.customBlack.c300,
            ),
            TextButton(
              onPressed: () {
                model.userLogout(context);
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.power_settings_new_rounded,
                    color: Colors.amber,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Çıkış",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.amber),
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
          ],
        ));
  }
}
