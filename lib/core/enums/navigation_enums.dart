import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';

enum NavigationEnums {
  home,
  customer,
  waitingdeliverydoc,
  authorized,
  tesdoc,
}

extension NavigationEnumsExtension on NavigationEnums {
  String get displayName {
    switch (this) {
      case NavigationEnums.home:
        return "Ana Sayfa";
      case NavigationEnums.customer:
        return "Müşteriler";
      case NavigationEnums.waitingdeliverydoc:
        return "Bekleyen Teslimler";
      case NavigationEnums.authorized:
        return "Yetki Belgeleri";
      case NavigationEnums.tesdoc:
        return "KYC Belgeleri";
    }
  }

  Widget get displayIcons {
    switch (this) {
      case NavigationEnums.home:
        return Icon(
          Icons.home_rounded,
          color: CustomThemeColors.customWhite,
        );
      case NavigationEnums.customer:
        return Icon(
          Icons.group_rounded,
          color: CustomThemeColors.customWhite,
        );
      case NavigationEnums.waitingdeliverydoc:
        return Icon(
          Icons.list_alt_rounded,
          color: CustomThemeColors.customWhite,
        );
      case NavigationEnums.authorized:
        return Icon(
          Icons.contact_page_rounded,
          color: CustomThemeColors.customWhite,
        );
      case NavigationEnums.tesdoc:
        return Icon(
          Icons.edit_document,
          color: CustomThemeColors.customWhite,
        );
    }
  }
}
