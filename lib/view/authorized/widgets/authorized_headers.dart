import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/view/authorized/widgets/authorized_grid_skeleton.dart';

class AuthorizedHeaders extends StatelessWidget {
  const AuthorizedHeaders({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? pageStyle =
        Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            );
    return AuthorizedGridSkeleton(
      style: Text(
        "Tür",
        style: pageStyle,
      ),
      firstDate: Text(
        "Başlangıç Tar",
        style: pageStyle,
      ),
      secondDate: Text(
        "Bitiş Tar",
        style: pageStyle,
      ),
      customer: Text("Yetkilendiren", style: pageStyle),
      authorized: Text("Yetkili", style: pageStyle),
      apps: Text("İşlemler", style: pageStyle),
    );
  }
}
