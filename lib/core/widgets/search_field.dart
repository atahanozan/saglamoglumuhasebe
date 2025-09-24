import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.onSearchComplete,
    required this.cleanFilter,
    required this.formatters,
    required this.backColor,
    this.hintText = "Müşteri adı ile ara...",
    this.cleanBtnVisibility = true,
    this.padding,
  });

  final TextEditingController controller;
  final VoidCallback onSearchComplete;
  final VoidCallback cleanFilter;
  final List<TextInputFormatter> formatters;
  final String hintText;
  final Color backColor;
  final bool cleanBtnVisibility;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backColor,
      ),
      child: Row(
        children: [
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: CustomThemeColors.customWhite,
              ),
              child: TextField(
                controller: controller,
                onEditingComplete: onSearchComplete,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: hintText,
                  suffixIcon: Icon(Icons.search_rounded),
                ),
                inputFormatters: formatters,
              ),
            ),
          ),
          Visibility(
            visible: cleanBtnVisibility,
            child: IconButton(
              onPressed: cleanFilter,
              icon: Icon(
                Icons.clear_rounded,
                color: CustomThemeColors.customWhite,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
