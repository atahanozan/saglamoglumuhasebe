import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:saglamoglu_muhasebe/helper/custom_widget.dart';
import 'package:saglamoglu_muhasebe/helper/ui/custom_colors.dart';
import 'package:saglamoglu_muhasebe/helper/utils/texts.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({super.key});

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final CustomWidgets customWidgets = CustomWidgets();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  final TextEditingController ibanController = TextEditingController();
  final TextEditingController placeOfBirthController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  final TextEditingController motherName = TextEditingController();
  final TextEditingController fatherName = TextEditingController();
  final TextEditingController dateOfBirth = TextEditingController();
  final TextEditingController telController = TextEditingController();
  final CustomWidgets _customWidgets = CustomWidgets();
  XFile? frontImage;
  XFile? backImage;
  XFile? ibanImage;
  final ImagePicker _picker = ImagePicker();
  final TextRecognizer textRecognizer = TextRecognizer();
  List<String> recognizedTexts = [];
  String tckn = "";
  List<String> customerIds = [
    "14584330750",
    "14584330751",
  ];

  String frontIdPath = Texts.fronstImgPath;

  String backIdPath = Texts.backImgPath;
  Future<void> pickFrontImageButton() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    final imageFile = await image.readAsBytes();
    final ref = FirebaseStorage.instance.ref();
    final child = ref.child("images/${image.name}");
    final uploadTask = child.putData(imageFile);

    uploadTask.snapshotEvents.listen((event) async {
      if (event.state == TaskState.success) {
        var imagePath = await event.ref.getDownloadURL();
        setState(() {
          frontIdPath = imagePath.toString();
        });
      }
    });

    setState(() {
      frontImage = image;
    });
  }

  Future<void> pickBackImageButton() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    final imageFile = await image.readAsBytes();
    final ref = FirebaseStorage.instance.ref();
    final child = ref.child("images/${image.name}");
    final uploadTask = child.putData(imageFile);

    uploadTask.snapshotEvents.listen((event) async {
      if (event.state == TaskState.success) {
        var imagePath = await event.ref.getDownloadURL();
        setState(() {
          backIdPath = imagePath.toString();
        });
      }
    });

    setState(() {
      backImage = image;
    });
  }

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    adressController.dispose();
    ibanController.dispose();
    placeOfBirthController.dispose();
    jobController.dispose();
    motherName.dispose();
    fatherName.dispose();
    dateOfBirth.dispose();
    telController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: CustomColors.customWhite,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    pickFrontImageButton();
                  },
                  child: Image.network(
                    frontIdPath,
                    height: 100,
                    width: 200,
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    pickBackImageButton();
                  },
                  child: Image.network(
                    backIdPath,
                    height: 100,
                    width: 200,
                  ),
                ),
              ),
            ],
          ),
          Form(
            autovalidateMode: AutovalidateMode.always,
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: idController,
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: '###########',
                      filter: {'#': RegExp(r'[0-9]')},
                    )
                  ],
                  decoration: InputDecoration(
                    labelText: "TCKN",
                    labelStyle: GoogleFonts.raleway(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onSaved: (newValue) {
                    setState(() {
                      tckn = newValue!;
                    });
                  },
                  validator: (value) {
                    if (customerIds.contains(value!)) {
                      return Texts.errCustomerAddedBefore;
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: nameController,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: Texts.nameSurnem,
                    labelStyle: GoogleFonts.raleway(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: ibanController,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: '## #### #### #### #### #### ##',
                      filter: {'#': RegExp(r'[0-9]')},
                    )
                  ],
                  decoration: InputDecoration(
                    labelText: Texts.iban,
                    labelStyle: GoogleFonts.raleway(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "01 2345 6789 1011 1213 1415 16",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: adressController,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: Texts.adress,
                    labelStyle: GoogleFonts.raleway(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: telController,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: '#### ### ## ##',
                      filter: {'#': RegExp(r'[0-9]')},
                    )
                  ],
                  decoration: InputDecoration(
                    labelText: Texts.phone,
                    labelStyle: GoogleFonts.raleway(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "0555 555 55 55",
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: jobController,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: Texts.job,
                    labelStyle: GoogleFonts.raleway(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: placeOfBirthController,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: Texts.placeOfBirth,
                    labelStyle: GoogleFonts.raleway(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: motherName,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: Texts.motherName,
                    labelStyle: GoogleFonts.raleway(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: fatherName,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: Texts.fatherName,
                    labelStyle: GoogleFonts.raleway(),
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: dateOfBirth,
                  autofocus: true,
                  keyboardType: TextInputType.text,
                  inputFormatters: [
                    MaskTextInputFormatter(
                      mask: '##.##.####',
                      filter: {'#': RegExp(r'[0-9]')},
                    )
                  ],
                  decoration: InputDecoration(
                      labelText: Texts.dateOfBirth,
                      labelStyle: GoogleFonts.raleway(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "GG.AA.YYYY"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  idController.text.isNotEmpty &&
                  adressController.text.isNotEmpty &&
                  placeOfBirthController.text.isNotEmpty &&
                  jobController.text.isNotEmpty) {
                _firestore.collection("customers").add({
                  "datetime": DateTime.now().toString(),
                  "name": nameController.text.toUpperCase(),
                  "id": idController.text,
                  "microId": "+MicroID",
                  "adress": adressController.text.toUpperCase(),
                  "placeofbirth": placeOfBirthController.text.toUpperCase(),
                  "job": jobController.text.toUpperCase(),
                  "statu": false,
                  "frontidpath": frontIdPath,
                  "backidpath": backIdPath,
                  "phone": telController.text,
                  "iban": ibanController.text,
                  "mothername": motherName.text.toUpperCase(),
                  "fathername": fatherName.text.toUpperCase(),
                  "dateofbirth": dateOfBirth.text,
                  "customertype": "BİREYSEL",
                  "docId": DateTime.now().millisecondsSinceEpoch,
                }).whenComplete(() {
                  setState(() {
                    nameController.clear();
                    idController.clear();
                    adressController.clear();
                    ibanController.clear();
                    placeOfBirthController.clear();
                    jobController.clear();
                    telController.clear();
                    motherName.clear();
                    fatherName.clear();
                    dateOfBirth.clear();
                    _customWidgets.customSnackBar(
                        context, Texts.msgCustomerAdded);
                    frontIdPath = Texts.fronstImgPath;
                    backIdPath = Texts.backImgPath;
                    Navigator.pop(context);
                  });
                });
              } else {
                _customWidgets.customSnackBar(context, Texts.errFillTheBlanks);
              }
            },
            child: const Text(Texts.btnCustomerAdd),
          ),
        ],
      ),
    );
  }
}
