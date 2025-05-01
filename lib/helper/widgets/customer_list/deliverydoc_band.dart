import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/helper/ui/money_text_formatter.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/custom_dropdown.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/pick_date_widget.dart';

class DeliverydocBand extends StatelessWidget {
  const DeliverydocBand({
    super.key,
    required this.visibility,
    required this.datePick,
    required this.saveFun,
    required this.date,
    required this.value,
    required this.drpBtn,
    required this.onChanged,
    required this.priceController,
  });

  final bool visibility;
  final VoidCallback datePick;
  final VoidCallback saveFun;
  final String date;
  final String value;
  final List<String> drpBtn;
  final Function(String?) onChanged;
  final TextEditingController priceController;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visibility,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          const Text("Tarih  "),
          Expanded(
            child: PickDateWidget(
              picakedDate: date,
              pickDateFunc: datePick,
            ),
          ),
          const SizedBox(width: 20),
          const Text("Firma  "),
          Expanded(
            child: CustomDropdown(
              btnValue: value,
              onchangeFun: onChanged,
              valueList: drpBtn,
            ),
          ),
          const SizedBox(width: 20),
          const Text("Tutar  "),
          Expanded(
            child: TextField(
              controller: priceController,
              textAlign: TextAlign.end,
              inputFormatters: [
                MoneyTextFormatter(),
              ],
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              )),
            ),
          ),
          const SizedBox(width: 20),
          ElevatedButton(
            onPressed: saveFun,
            child: const Icon(Icons.save),
          )
        ],
      ),
    );
  }
}
