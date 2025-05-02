import 'package:flutter/material.dart';
import 'package:saglamoglu_muhasebe/service/data_services.dart';

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
    required this.docId,
    required this.admin,
  });

  final String docType;
  final String customerTckn;
  final String customerName;
  final String authorizedTckn;
  final String authorizedName;
  final String expireDate;
  final String? docId;
  final Color docColor;
  final bool admin;

  @override
  Widget build(BuildContext context) {
    final TextTheme pageStyle = Theme.of(context).textTheme;
    final DataServices dataServices = DataServices();
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
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Text(authorizedTckn),
          ),
          Expanded(
            child: Text(authorizedName),
          ),
          Expanded(
            child: Text(expireDate),
          ),
          Visibility(
            visible: admin,
            child: Expanded(
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
                    onPressed: () {
                      dataServices.deleteAuthorizedDoc(
                        context,
                        customerName,
                        docId,
                      );
                    },
                    icon: Icon(
                      Icons.delete_rounded,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
