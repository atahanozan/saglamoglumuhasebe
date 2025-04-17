import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/helper/ui/uppercase_text_formatter.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/customer_list/data_info_band.dart';
import 'package:saglamoglu_muhasebe/pages/customers/add_customer.dart';

class CustomersList extends StatefulWidget {
  const CustomersList({super.key});

  @override
  State<CustomersList> createState() => _CustomersListState();
}

class _CustomersListState extends State<CustomersList> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _tcknController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  List<String> tckns = [];
  List<String> names = [];
  List<String> companies = ["Sağlam", "Elmina"];
  String name = "";
  String companyName = "Sağlam";
  String date = DateTime.now().toString().split(" ")[0];
  int customerCount = 0;
  bool visibility = false;

  Future<void> addTckn() async {
    await firestore.collection("deliverycustomers").get().then((value) {
      for (var element in value.docs) {
        tckns.add(element["tcknvkn"]);
        names.add(element["name"]);
        setState(() {
          if (value.docs.length < 50) {
            customerCount = value.docs.length;
          } else {
            customerCount = 50;
          }
        });
      }
    });
  }

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

  @override
  void initState() {
    addTckn();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _tcknController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
                    addTckn();
                  },
                  child: const Text("Yenile"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const AddCustomer(),
                      ),
                    );
                  },
                  child: const Text("Müşteri Ekle"),
                ),
              ],
            ),
            const Divider(),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  name = value;
                });
              },
            ),
            Flexible(
              child: StreamBuilder(
                stream: firestore
                    .collection("deliverycustomers")
                    .where("name", isGreaterThan: name)
                    .orderBy("name", descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? const CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot docs = snapshot.data!.docs[index];

                            return DataInfoBand(
                              customerName: docs['name'],
                              customerId: docs['tcknvkn'],
                              deleteCustomer: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text(docs["name"]),
                                    content: const Text("Müşteriyi sil ?"),
                                    actions: [
                                      OutlinedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("İptal"),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            firestore
                                                .collection("deliverycustomers")
                                                .doc(docs.id)
                                                .delete()
                                                .whenComplete(() {
                                              addTckn();
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                              }
                                            });
                                          },
                                          child: const Text("Sil"))
                                    ],
                                  ),
                                );
                              },
                              editCustomer: () {
                                setState(() {
                                  _nameController.text = docs["name"];
                                  _tcknController.text = docs["tcknvkn"];
                                });
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text("Düzenle"),
                                    content: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.6,
                                      width: 450,
                                      child: Column(
                                        children: [
                                          const Divider(),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              const Expanded(
                                                  flex: 1,
                                                  child: Text("TCKN / VKN")),
                                              const SizedBox(width: 15),
                                              Expanded(
                                                  flex: 3,
                                                  child: TextField(
                                                    controller: _tcknController,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        hintText:
                                                            docs["tcknvkn"]),
                                                  ))
                                            ],
                                          ),
                                          const SizedBox(height: 25),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              const Expanded(
                                                  flex: 1, child: Text("İsim")),
                                              const SizedBox(width: 15),
                                              Expanded(
                                                  flex: 3,
                                                  child: TextField(
                                                    controller: _nameController,
                                                    inputFormatters: [
                                                      UppercaseTextFormatter()
                                                    ],
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        hintText: docs["name"]),
                                                  ))
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    actions: [
                                      OutlinedButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text("İptal"),
                                      ),
                                      ElevatedButton(
                                          onPressed: () {
                                            firestore
                                                .collection("deliverycustomers")
                                                .doc(docs.id)
                                                .set({
                                              "name": _nameController.text,
                                              "tcknvkn": _tcknController.text,
                                            }).whenComplete(() {
                                              addTckn();
                                              if (context.mounted) {
                                                Navigator.pop(context);
                                              }
                                            });
                                          },
                                          child: const Text("Düzenle"))
                                    ],
                                  ),
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
                              tcknvkn: docs["tcknvkn"],
                            );
                          },
                        );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Daha Fazla Göster"),
            ),
          ],
        ),
      ),
    );
  }
}
