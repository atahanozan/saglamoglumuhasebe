import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/core/model/tesdoc_model.dart';

class TesdocNameSection extends StatelessWidget {
  const TesdocNameSection({
    super.key,
    required this.model,
    required this.tesdocDelete,
  });

  final TesdocModel model;
  final VoidCallback tesdocDelete;

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            model.customerName.toString(),
            style: pageStyle.titleMedium,
          ),
          SizedBox(height: 10),
          Text(
            model.customerPhone.toString(),
            style: pageStyle.bodySmall,
          ),
          Text(
            model.finalDate(),
            style: pageStyle.bodySmall,
          ),
          Spacer(),
          IconButton(
            onPressed: tesdocDelete,
            icon: Icon(Icons.delete),
          ),
        ],
      ),
    );
  }
}
