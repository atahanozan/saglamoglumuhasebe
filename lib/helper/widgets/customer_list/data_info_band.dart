import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/customer_list/add_authorized.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/customer_list/deliverydoc_band.dart';
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
    required this.customerDate,
    required this.addAuthorized,
  });

  final String customerId;
  final String customerName;
  final String date;
  final String customerDate;
  final String value;
  final String tcknvkn;
  final VoidCallback deleteCustomer;
  final VoidCallback editCustomer;
  final VoidCallback datePick;
  final VoidCallback addAuthorized;
  final bool visibility;
  final List<String> drpBtn;
  final Function(String?) onChanged;
  final TextEditingController priceController;

  @override
  State<DataInfoBand> createState() => _DataInfoBandState();
}

class _DataInfoBandState extends State<DataInfoBand> {
  final DataServices dataServices = DataServices();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController tcknController = TextEditingController();
  bool visibility = false;
  bool addAuthVisibility = false;
  String btnNameDeliv = "Teslim";
  String firstDate = DateTime.now().toString().split(" ")[0];
  String secondDate =
      DateTime.now().add(const Duration(days: 365)).toString().split(" ")[0];
  List<String> dropDownList = [
    "Talimat",
    "Vekalet",
  ];
  String addAuthValue = "Talimat";

  Future<void> pickFirstDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        firstDate = picked.toString().split(" ")[0];
        secondDate =
            picked.add(const Duration(days: 365)).toString().split(" ")[0];
      });
    }
  }

  Future<void> pickSecondDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(
        const Duration(days: 365),
      ),
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(
        const Duration(days: 3650),
      ),
    );

    if (picked != null) {
      setState(() {
        secondDate = picked.toString().split(" ")[0];
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    tcknController.dispose();
    super.dispose();
  }

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
          AddAuthorized(
            addAuthVisibility: addAuthVisibility,
            dropDownList: dropDownList,
            drpDownBtnFunc: (value) {
              setState(() {
                addAuthValue = value.toString();
              });
            },
            addAuthValue: addAuthValue,
            firstDate: firstDate,
            secondDate: secondDate,
            pickFirstDate: () {
              pickFirstDate();
            },
            pickSecondDate: () {
              pickSecondDate();
            },
            saveFun: () {
              if (tcknController.text.isNotEmpty &&
                  nameController.text.isNotEmpty) {
                dataServices
                    .addAuthorized(
                  firstDate,
                  secondDate,
                  widget.tcknvkn,
                  widget.customerName,
                  tcknController.text,
                  nameController.text,
                  addAuthValue,
                )
                    .then((value) {
                  setState(() {
                    addAuthVisibility = false;
                    tcknController.clear();
                    nameController.clear();
                  });
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Lütfen bilgileri esiksiz doldurunuz."),
                    backgroundColor: Colors.redAccent.shade200,
                  ),
                );
              }
            },
            tcknController: tcknController,
            nameController: nameController,
            closeFunc: () {
              setState(() {
                addAuthVisibility = false;
              });
            },
          ),
          DeliverydocBand(
            visibility: visibility,
            datePick: widget.datePick,
            saveFun: () {
              if (widget.priceController.text.isNotEmpty) {
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
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Lütfen bilgileri esiksiz doldurunuz."),
                    backgroundColor: Colors.redAccent.shade200,
                  ),
                );
              }
            },
            date: widget.date,
            value: widget.value,
            drpBtn: widget.drpBtn,
            onChanged: widget.onChanged,
            priceController: widget.priceController,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                widget.customerId.characters.length == 10
                    ? Icons.cases_rounded
                    : Icons.account_circle_rounded,
                size: 15,
                color: Colors.black54,
              ),
              const SizedBox(width: 8),
              Text(widget.customerDate),
              const SizedBox(width: 20),
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
                    IconButton(
                      onPressed: () {
                        setState(() {
                          addAuthVisibility = true;
                        });
                      },
                      icon: Icon(
                        Icons.person_add_alt_1_rounded,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: widget.editCustomer,
                      icon: Icon(
                        Icons.edit_rounded,
                      ),
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
