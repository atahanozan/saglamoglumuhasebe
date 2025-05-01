import 'package:flutter/material.dart';

class AuthorizedInfoBand extends StatelessWidget {
  const AuthorizedInfoBand({
    super.key,
    required this.docType,
    required this.customerTckn,
    required this.customerName,
    required this.authorizedTckn,
    required this.authorizedName,
    required this.expireDate,
    required this.docColor,
  });

  final String docType;
  final String customerTckn;
  final String customerName;
  final String authorizedTckn;
  final String authorizedName;
  final String expireDate;
  final Color docColor;

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
          color: Colors.grey.shade200,
        )),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Text(
              docType,
              style: pageStyle.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              customerTckn,
              style: pageStyle.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              customerName,
              style: pageStyle.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(authorizedTckn),
          ),
          Expanded(
            child: Text(authorizedName),
          ),
          Expanded(
            child: Text(expireDate),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit_rounded,
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete_rounded,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
