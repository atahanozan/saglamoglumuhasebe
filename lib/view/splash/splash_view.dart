import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/view/splash/splash_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  SplashViewModel model = SplashViewModel.init;

  @override
  void initState() {
    model.updateSplash(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          "assets/images/saglamoglu_logo.svg",
          colorFilter: ColorFilter.mode(
            CustomThemeColors.customYellow.c800 ?? Colors.amber,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}
