import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saglamoglu_muhasebe/helper/widgets/delivery_docs/delivery_doc_info_line.dart';

class DeliveryDocsList extends StatefulWidget {
  const DeliveryDocsList({super.key, this.admin = false});

  final bool admin;

  @override
  State<DeliveryDocsList> createState() => _DeliveryDocsListState();
}

class _DeliveryDocsListState extends State<DeliveryDocsList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();
  String name = "";
  String filterBtnName = "";
  bool btnVisibility = false;
  Icon filterIcon = const Icon(Icons.arrow_drop_down_circle_outlined);
  Stream<QuerySnapshot<Map<String, dynamic>>> customSnapshot = FirebaseFirestore
      .instance
      .collection("deliverydocs")
      .orderBy("id", descending: true)
      .snapshots();

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
        filterBtnName = pickedDate.toString().split(" ")[0];
        btnVisibility = true;
        customSnapshot = FirebaseFirestore.instance
            .collection("deliverydocs")
            .where("date", isEqualTo: pickedDate.toString().split(" ")[0])
            .snapshots();
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
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
                  customSnapshot = FirebaseFirestore.instance
                      .collection("deliverydocs")
                      .where("name", isGreaterThan: name)
                      .snapshots();
                });
              },
            ),
            Visibility(
              visible: btnVisibility,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.grey.shade300),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Filtreler:   "),
                    OutlinedButton(
                      onPressed: () {
                        setState(() {
                          customSnapshot = FirebaseFirestore.instance
                              .collection("deliverydocs")
                              .orderBy("id", descending: true)
                              .snapshots();
                          btnVisibility = false;
                          filterBtnName = "";
                          filterIcon =
                              const Icon(Icons.arrow_drop_down_circle_outlined);
                        });
                      },
                      child: Text(filterBtnName),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Tarih",
                      style: pageStyle.titleMedium,
                    ),
                    IconButton(
                      onPressed: () {
                        changeFilter(context);
                      },
                      icon: filterIcon,
                    )
                  ],
                )),
                const SizedBox(width: 20),
                Expanded(
                    child: Text(
                  "İsim / Ünvan",
                  style: pageStyle.titleMedium,
                )),
                const SizedBox(width: 20),
                Expanded(
                    child: Text(
                  "Şirket",
                  style: pageStyle.titleMedium,
                )),
                const SizedBox(width: 20),
                Expanded(
                    child: Text(
                  "Tutar",
                  style: pageStyle.titleMedium,
                )),
                const SizedBox(width: 20),
                Expanded(
                    child: Text(
                  "İşlemler",
                  style: pageStyle.titleMedium,
                )),
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
