import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/service/data_services.dart';

class DataInfoBand extends StatefulWidget {
  const DataInfoBand({
    super.key,
    required this.customerName,
    required this.customerId,
    required this.deleteCustomer,
    required this.editCustomer,
    required this.date,
    required this.visibility,
    required this.datePick,
    required this.drpBtn,
    required this.onChanged,
    required this.value,
    required this.priceController,
    required this.tcknvkn,
  });

  final String customerId;
  final String customerName;
  final String date;
  final String value;
  final String tcknvkn;
  final VoidCallback deleteCustomer;
  final VoidCallback editCustomer;
  final VoidCallback datePick;
  final bool visibility;
  final List<String> drpBtn;
  final Function(String?) onChanged;
  final TextEditingController priceController;

  @override
  State<DataInfoBand> createState() => _DataInfoBandState();
}

class _DataInfoBandState extends State<DataInfoBand> {
  final DataServices dataServices = DataServices();
  bool visibility = false;
  String btnNameDeliv = "Teslim";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: visibility,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text("Tarih  "),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: widget.datePick,
                        child: Text(widget.date),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text("Firma  "),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButton(
                        underline: const SizedBox(),
                        alignment: AlignmentDirectional.centerEnd,
                        items: widget.drpBtn
                            .map((companies) => DropdownMenuItem(
                                  value: companies,
                                  child: Text(companies),
                                ))
                            .toList(),
                        onChanged: widget.onChanged,
                        value: widget.value,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  const Text("Tutar  "),
                  Expanded(
                    child: TextField(
                      controller: widget.priceController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      dataServices.addDeliveryDoc(
                        widget.customerName,
                        widget.tcknvkn,
                        widget.priceController.text,
                        widget.value,
                        widget.date,
                      );
                      setState(() {
                        visibility = false;
                        widget.priceController.clear();
                        btnNameDeliv = "Teslim";
                      });
                    },
                    child: const Icon(Icons.save),
                  )
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: Text(widget.customerId)),
              Expanded(
                  child: Text(
                widget.customerName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
              const SizedBox(width: 20),
              Expanded(
                child: Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          visibility = !visibility;
                          btnNameDeliv = visibility ? "Kapat" : "Teslim";
                        });
                      },
                      child: Text(btnNameDeliv),
                    ),
                    const SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: widget.editCustomer,
                      child: const Text("Düzenle"),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: widget.deleteCustomer,
                      icon: const Icon(Icons.delete),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
