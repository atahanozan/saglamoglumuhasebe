import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/extensions/colors_extension.dart';
import 'package:saglamoglu_muhasebe/core/theme/custom_colors.dart';
import 'package:saglamoglu_muhasebe/view/changepassword/change_password_view.dart';

class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
    required this.userName,
    required this.usersVisibility,
    required this.logoutFunc,
    required this.usersFunc,
  });

  final String userName;
  final bool usersVisibility;
  final VoidCallback logoutFunc;
  final VoidCallback usersFunc;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      builder: (context, controller, child) {
        return InkWell(
          onTap: () {
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: CustomThemeColors.customYellow.c700,
            ),
            child: Text(
              userName.characters.first,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: CustomThemeColors.customBlack.c700,
                  ),
            ),
          ),
        );
      },
      menuChildren: [
        Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(userName, style: Theme.of(context).textTheme.headlineMedium),
              Divider(),
              SizedBox(height: 12),
              Visibility(
                visible: usersVisibility,
                child: TextButton(
                  onPressed: usersFunc,
                  child: Text("Kullanıcılar"),
                ),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ChangePasswordView())),
                child: Text("Şifre Değiştir"),
              ),
              SizedBox(height: 12),
              TextButton(
                onPressed: logoutFunc,
                child: Text("Çıkış"),
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
