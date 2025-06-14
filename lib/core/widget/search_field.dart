import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.controller,
    required this.onSearchComplete,
    required this.cleanFilter,
    required this.formatters,
  });

  final TextEditingController controller;
  final VoidCallback onSearchComplete;
  final VoidCallback cleanFilter;
  final List<TextInputFormatter> formatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 22,
      ),
      decoration: BoxDecoration(
        color: CustomThemeColors.customBlack.c800,
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
                  hintText: "Müşteri adı ile ara...",
                  suffixIcon: Icon(Icons.search_rounded),
                ),
                inputFormatters: formatters,
              ),
            ),
          ),
          IconButton(
            onPressed: cleanFilter,
            icon: Icon(
              Icons.clear_rounded,
              color: CustomThemeColors.customWhite,
            ),
          ),
        ],
      ),
    );
  }
}
