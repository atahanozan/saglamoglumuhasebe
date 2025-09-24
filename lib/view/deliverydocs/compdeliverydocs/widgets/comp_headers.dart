import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/view/deliverydocs/waitingdeliverydoc/widgets/grid_skeleton.dart';

class CompHeaders extends StatelessWidget {
  const CompHeaders({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? pageStyle =
        Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            );
    return GridSkeleton(
      apps: Text(
        "İşlemler",
        style: pageStyle,
      ),
      createdDate: Text(
        "Oluşturma Tar",
        style: pageStyle,
      ),
      customer: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Müşteri",
            style: pageStyle,
            textAlign: TextAlign.left,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "Firma",
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
      firstTransaction: Text(
        "Şube Durumu",
        textAlign: TextAlign.left,
        style: pageStyle,
      ),
      lasUpdate: Text(
        "Son İşlem Tar",
        style: pageStyle,
      ),
      lastUser: Text(
        "Son İşlem Kullanıcı",
        style: pageStyle,
      ),
      price: Text(
        "Tutar",
        style: pageStyle,
      ),
      secondTransaction: Text(
        "Merkez Durumu",
        textAlign: TextAlign.left,
        style: pageStyle,
      ),
    );
  }
}
