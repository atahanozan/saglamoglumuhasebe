import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/view/main/widgets/side_bar_buttons.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
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
            const SizedBox(height: 50),
            Flexible(child: SideBarButtons()),
            Spacer(),
            Divider(
              color: Colors.grey.shade100,
            ),
            Text(
              "Sürüm: 33",
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: CustomThemeColors.customYellow.c800,
                  ),
            ),
            SizedBox(height: 18),
          ],
        ));
  }
}
