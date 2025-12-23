import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/model/auth_model.dart';
import 'package:saglamoglu_muhasebe/view/adduser/model/add_user_view_model.dart';

class UserGrid extends StatelessWidget {
  const UserGrid({
    super.key,
    required this.model,
    required this.addUserModel,
    required this.uid,
  });

  final AuthModel model;
  final AddUserViewModel addUserModel;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 5),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Colors.black38,
        ),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          addUserModel.userStatuIcon(model.statu),
          Expanded(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${model.name} ${model.lastName}"),
              Text(model.email.toString()),
            ],
          )),
          Expanded(
              child: Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  if (model.admin == true) {
                    addUserModel.authController.updateUserInfo(
                      uid,
                      {
                        "admin": false,
                        "uid": uid,
                      },
                      context,
                    );
                  } else {
                    addUserModel.authController.updateUserInfo(
                      uid,
                      {
                        "admin": true,
                        "uid": uid,
                      },
                      context,
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor:
                        model.admin == true ? Colors.green : Colors.blue,
                    fixedSize: Size.fromWidth(100)),
                child: Text(model.userCompany()),
              ),
              IconButton(
                onPressed: () {
                  if (model.passwordNew == true) {
                    addUserModel.authController.updateUserInfo(
                      uid,
                      {
                        "passwordNew": false,
                        "uid": uid,
                      },
                      context,
                    );
                  } else {
                    addUserModel.authController.updateUserInfo(
                      uid,
                      {
                        "passwordNew": true,
                        "uid": uid,
                      },
                      context,
                    );
                  }
                },
                icon: addUserModel.userPasswordStatuIcon(model.passwordNew),
              ),
              IconButton(
                  onPressed: () {
                    if (model.statu == true) {
                      addUserModel.authController.updateUserInfo(
                        uid,
                        {
                          "statu": false,
                          "uid": uid,
                        },
                        context,
                      );
                    } else {
                      addUserModel.authController.updateUserInfo(
                        uid,
                        {
                          "statu": true,
                          "uid": uid,
                        },
                        context,
                      );
                    }
                  },
                  icon: addUserModel.userStatuButtonIcon(model.statu)),
            ],
          )),
        ],
      ),
    );
  }
}
