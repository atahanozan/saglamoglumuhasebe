import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';

class HeaderLineWidget extends StatelessWidget {
  const HeaderLineWidget({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 22,
      ),
      margin: const EdgeInsets.only(bottom: 22),
      decoration: BoxDecoration(color: CustomThemeColors.customBlack.c800),
      child: Text(
        "Hoş geldin $userName",
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: CustomThemeColors.customWhite,
            ),
      ),
    );
  }
}
