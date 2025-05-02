import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/helper/ui/uppercase_text_formatter.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/delivery_docs/delivery_doc_info_line.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/pick_date_widget.dart';
import 'package:saglamoglu_muhasebe/service/data_services.dart';

class DoneDeliveryDocs extends StatefulWidget {
  const DoneDeliveryDocs({super.key, this.admin = false});

  final bool admin;

  @override
  State<DoneDeliveryDocs> createState() => _DoneDeliveryDocsState();
}

class _DoneDeliveryDocsState extends State<DoneDeliveryDocs> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final DataServices dataServices = DataServices();
  final List<String> companies = [
    "Sağlam",
    "Elmina",
  ];
  String name = "";
  String price = "";
  String filter1 = "Sağlam";
  String filter2 = "Elmina";
  String? filter3 = "";
  bool btnVisibility = false;
  Icon filterIcon = const Icon(Icons.arrow_drop_down_circle_outlined);
  Stream customSnapshot = DataServices().deliveryDocsCompanyFilters(
    true,
    "Sağlam",
    "Elmina",
  );

  Future<void> changeFilter(BuildContext myContext) async {
    final DateTime? pickedDate = await showDatePicker(
      context: myContext,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        filterIcon = const Icon(Icons.arrow_drop_down_circle_rounded);
        filter3 = pickedDate.toString().split(" ")[0];
        btnVisibility = true;
        customSnapshot = dataServices.deliveryDocsDateFilter(
          pickedDate.toString().split(" ")[0],
          true,
          filter1,
          filter2,
        );
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Teslim Listesi",
              style: GoogleFonts.raleway(fontSize: 25),
            ),
            const Divider(),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      prefixIcon: const Icon(Icons.search),
                    ),
                    inputFormatters: [
                      UppercaseTextFormatter(),
                    ],
                    onEditingComplete: () {
                      setState(() {
                        customSnapshot = dataServices.deliveryDocsNameFilters(
                          true,
                          _nameController.text,
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.grey.shade300,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text("Tarih", style: pageStyle.bodySmall),
                  SizedBox(width: 15),
                  Expanded(
                    child: PickDateWidget(
                      picakedDate: filter3.toString(),
                      pickDateFunc: () {
                        changeFilter(context);
                      },
                    ),
                  ),
                  SizedBox(width: 40),
                  Text("Firma", style: pageStyle.bodySmall),
                  SizedBox(width: 15),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade500,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButton(
                          value: filter1,
                          underline: SizedBox(),
                          items: companies.map((company) {
                            return DropdownMenuItem(
                              value: company,
                              child: Text(company),
                            );
                          }).toList(),
                          onChanged: (value) {
                            if (filter3 == "") {
                              setState(() {
                                filter1 = value.toString();
                                filter2 = value.toString();
                                customSnapshot =
                                    dataServices.deliveryDocsCompanyFilters(
                                  true,
                                  value.toString(),
                                  value.toString(),
                                );
                              });
                            } else {
                              setState(() {
                                filter1 = value.toString();
                                filter2 = value.toString();
                                customSnapshot =
                                    dataServices.deliveryDocsDateFilter(
                                  filter3.toString(),
                                  true,
                                  value.toString(),
                                  value.toString(),
                                );
                              });
                            }
                          }),
                    ),
                  ),
                  SizedBox(width: 40),
                  Text(
                    "Tutar",
                    style: pageStyle.bodySmall,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      controller: _priceController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                      onEditingComplete: () {
                        setState(() {
                          customSnapshot =
                              dataServices.deliveryDocsPriceFilters(
                            true,
                            _priceController.text,
                          );
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        customSnapshot =
                            DataServices().deliveryDocsCompanyFilters(
                          true,
                          "Sağlam",
                          "Elmina",
                        );
                        btnVisibility = false;
                        filter3 = "";
                        filterIcon =
                            const Icon(Icons.arrow_drop_down_circle_outlined);
                        _priceController.clear();
                        _nameController.clear();
                      });
                    },
                    child: Text("Temizle"),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(width: 38),
                Text(
                  "Tarih          ",
                  style: pageStyle.titleMedium,
                ),
                const SizedBox(width: 30),
                Expanded(
                    child: Text(
                  "İsim / Ünvan",
                  textAlign: TextAlign.left,
                  style: pageStyle.titleMedium,
                )),
                const SizedBox(width: 20),
                Text(
                  "Şirket",
                  textAlign: TextAlign.left,
                  style: pageStyle.titleMedium,
                ),
                const SizedBox(width: 20),
                Expanded(
                    child: Text(
                  "Tutar",
                  textAlign: TextAlign.right,
                  style: pageStyle.titleMedium,
                )),
                const SizedBox(width: 30),
                SizedBox(
                  width: 200,
                  child: Text(
                    "İşlemler",
                    style: pageStyle.titleMedium,
                  ),
                ),
              ],
            ),
            Divider(
              thickness: 2,
              color: Colors.grey.shade800,
            ),
            Flexible(
              child: StreamBuilder(
                stream: customSnapshot,
                builder: (context, snapshot) {
                  return !snapshot.hasData
                      ? const CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot data = snapshot.data!.docs[index];

                            return DeliveryDocInfoLine(
                              admin: true,
                              date: data["date"],
                              name: data["name"],
                              company: data["company"],
                              price: data["price"],
                              tcknvkn: data["tcknvkn"],
                              deleteDoc: () {
                                if (widget.admin) {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      title: Text(data["name"]),
                                      content:
                                          const Text("Teslim dosyasını sil ?"),
                                      actions: [
                                        OutlinedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text("İptal"),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              _firestore
                                                  .collection("deliverydocs")
                                                  .doc(data.id)
                                                  .delete()
                                                  .whenComplete(() {
                                                if (context.mounted) {
                                                  Navigator.pop(context);
                                                }
                                              });
                                            },
                                            child: const Text("Sil"))
                                      ],
                                    ),
                                  );
                                } else {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            "Bu alan için yetkiniz bulunmamaktadır !"),
                                        backgroundColor:
                                            Colors.redAccent.shade200,
                                      ),
                                    );
                                  }
                                }
                              },
                              statu: data["statu"],
                              statuIcon: Icon(
                                Icons.done,
                                color: Colors.green.shade700,
                              ),
                              statuChange: () async {
                                dataServices.editDeliveryDocStatu(
                                  context,
                                  data["name"],
                                  data["statu"],
                                  data.id,
                                );
                              },
                              editDoc: () {},
                              proccesStatuChange: () {},
                              proccesStatu: true,
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
