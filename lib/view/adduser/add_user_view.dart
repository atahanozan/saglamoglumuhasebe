import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:saglamoglu_muhasebe/core/model/auth_model.dart';
import 'package:saglamoglu_muhasebe/core/widgets/custom_formfield_widget.dart';
import 'package:saglamoglu_muhasebe/view/adduser/model/add_user_view_model.dart';
import 'package:saglamoglu_muhasebe/view/adduser/widgets/user_grid.dart';

class AddUserView extends StatelessWidget {
  const AddUserView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size pageSize = MediaQuery.of(context).size;
    final TextTheme pageStyle = Theme.of(context).textTheme;
    final AddUserViewModel model = AddUserViewModel.instance;
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcılar"),
      ),
      body: Obx(
        () => Container(
          height: pageSize.height,
          width: pageSize.width,
          padding: const EdgeInsets.symmetric(
            vertical: 32,
            horizontal: 28,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomFormfieldWidget(
                formName: "E-mail",
                inputFormatter: [
                  TextInputFormatter.withFunction((oldText, newText) {
                    var lastText =
                        newText.text.toLowerCase().replaceAll(" ", "");

                    return TextEditingValue(
                        selection: newText.selection, text: lastText);
                  })
                ],
                controller: model.emailController,
                isPassword: false,
                isObsecure: false,
                labelColor: Colors.black,
              ),
              CustomFormfieldWidget(
                formName: "İsim",
                inputFormatter: [
                  TextInputFormatter.withFunction((oldText, newText) {
                    var lastText = newText.text.characters.first.toUpperCase();
                    var secondText = newText.text
                        .replaceFirst(newText.text.characters.first, lastText);

                    return TextEditingValue(
                        selection: newText.selection, text: secondText);
                  })
                ],
                controller: model.nameController,
                isPassword: false,
                isObsecure: false,
                labelColor: Colors.black,
              ),
              CustomFormfieldWidget(
                formName: "Soyisim",
                inputFormatter: [
                  TextInputFormatter.withFunction((oldText, newText) {
                    var lastText = newText.text.characters.first.toUpperCase();
                    var secondText = newText.text
                        .replaceFirst(newText.text.characters.first, lastText);

                    return TextEditingValue(
                        selection: newText.selection, text: secondText);
                  })
                ],
                controller: model.lastNameController,
                isPassword: false,
                isObsecure: false,
                labelColor: Colors.black,
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        model.changeAdminStatu();
                      },
                      icon: model.admin.value == true
                          ? Icon(Icons.circle)
                          : Icon(Icons.circle_outlined)),
                  Text("Operasyon Çalışanı"),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  model.createNewUser(
                    model.nameController.text,
                    model.lastNameController.text,
                    model.emailController.text,
                    model.admin.value,
                    context,
                  );
                  Future.delayed(const Duration(milliseconds: 300), () {
                    model.nameController.clear();
                    model.lastNameController.clear();
                    model.emailController.clear();
                  });
                },
                child: Text("Kullanıcı Ekle"),
              ),
              Divider(),
              Text(
                "Kullanıcılar",
                style: pageStyle.headlineMedium,
              ),
              SizedBox(height: 18),
              Flexible(
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .orderBy("name")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            itemCount: snapshot.data?.docs.length,
                            itemBuilder: (context, index) {
                              QueryDocumentSnapshot snapshotData =
                                  snapshot.data!.docs[index];

                              AuthModel authModel = AuthModel()
                                  .fromJson(snapshot.data!.docs[index].data());
                              return UserGrid(
                                model: authModel,
                                addUserModel: model,
                                uid: snapshotData.id,
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
