import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';
import 'package:saglamoglu_muhasebe/helper/ui/uppercase_text_formatter.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/customer_list/data_info_band.dart';
import 'package:saglamoglu_muhasebe/pages/customers/add_customer.dart';
import 'package:saglamoglu_muhasebe/service/data_services.dart';

class CustomersList extends StatefulWidget {
  const CustomersList({
    super.key,
    required this.agentName,
    required this.agentLastName,
  });

  final String agentName;
  final String agentLastName;

  @override
  State<CustomersList> createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tcknController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _editNameController = TextEditingController();
  final DataServices dataServices = DataServices();

  List<String> tckns = [];
  List<String> names = [];
  List<String> companies = ["Sağlam", "Elmina"];
  String name = "";
  String companyName = "Sağlam";
  String date = DateTime.now().toString().split(" ")[0];
  int allCustomers = 0;
  bool visibility = false;

  Stream dataStream = DataServices().customersOrderedById();

  Future<void> datePick(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked.toString() != date) {
      setState(() {
        date = picked.toString().split(" ")[0];
      });
    }
  }

  Future<void> allCusomterCounts() async {
    await FirebaseFirestore.instance
        .collection("deliverycustomers")
        .count()
        .get()
        .then((value) {
      setState(() {
        allCustomers = value.count!;
      });
    });
  }

  @override
  void initState() {
    allCusomterCounts();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _tcknController.dispose();
    _priceController.dispose();
    _editNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.customYellow,
        foregroundColor: CustomColors.customBlack,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddCustomer(
                tckns: tckns,
                agentName: widget.agentName,
                agentLastname: widget.agentLastName,
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Müşteri Listesi",
                  style: GoogleFonts.raleway(fontSize: 25),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () {
                    allCusomterCounts();
                  },
                  child: Icon(Icons.refresh),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    inputFormatters: [
                      UppercaseTextFormatter(),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    onEditingComplete: () {
                      setState(() {
                        dataStream = dataServices
                            .customersOrderedByName(_nameController.text);
                      });
                    },
                  ),
                ),
                SizedBox(width: 20),
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _nameController.clear();
                      dataStream = dataServices.customersOrderedById();
                    });
                  },
                  child: Icon(Icons.clear_rounded),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Text(
                "Toplam müşteri adedi: $allCustomers",
                style: pageStyle.bodySmall,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  " Tarih          ",
                  style: pageStyle.titleMedium,
                ),
                SizedBox(width: 40),
                Expanded(
                    child: Text(
                  "TCKN / VKN",
                  style: pageStyle.titleMedium,
                )),
                Expanded(
                    child: Text(
                  "İsim / Ünvan",
                  style: pageStyle.titleMedium,
                )),
                Expanded(
                    child: Text(
                  "İşlemler",
                  style: pageStyle.titleMedium,
                )),
              ],
            ),
            Divider(),
            Flexible(
              child: StreamBuilder(
                stream: dataStream,
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? const CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot snapshotData =
                                snapshot.data!.docs[index];

                            return DataInfoBand(
                              customerName: snapshotData['name'],
                              customerId: snapshotData['tcknvkn'],
                              deleteCustomer: () {
                                dataServices.deleteCustomer(
                                  snapshotData.id,
                                  snapshotData['name'],
                                  context,
                                );
                              },
                              editCustomer: () {
                                setState(() {
                                  _nameController.text = snapshotData["name"];
                                  _tcknController.text =
                                      snapshotData["tcknvkn"];
                                });

                                dataServices.editCustomer(
                                  context,
                                  _tcknController,
                                  snapshotData["tcknvkn"],
                                  _editNameController,
                                  snapshotData["name"],
                                  snapshotData.id,
                                );
                              },
                              visibility: visibility,
                              date: date,
                              datePick: () {
                                datePick(context);
                              },
                              drpBtn: companies,
                              onChanged: (value) {
                                setState(() {
                                  companyName = value.toString();
                                });
                              },
                              value: companyName,
                              priceController: _priceController,
                              tcknvkn: snapshotData["tcknvkn"],
                              customerDate: snapshotData["date"],
                              addAuthorized: () {},
                              agentName: widget.agentName,
                              dataAgent: snapshotData
                                          .data()
                                          .toString()
                                          .split(":")
                                          .length ==
                                      5
                                  ? " "
                                  : "(${snapshotData['agentName']})",
                              agentLastName: widget.agentLastName,
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
