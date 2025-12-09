import 'package:saglamoglu_muhasebe/core/enums/tesdoc_enums.dart';

class TesdocModel {
  final int? id;
  final String? dateTime,
      customerName,
      customerTckn,
      customerPhone,
      starterUser,
      ikaStarterUser,
      signUser,
      ikaSignUser,
      checkUser,
      ikaCheckUser,
      ikaStartDateTime,
      signDateTime,
      ikaSignDateTime,
      checkDateTime,
      ikaCheckDateTime,
      tesStatu,
      ikaStatu,
      customerUid;
  final bool? onlyTes;
  TesdocModel({
    this.id,
    this.dateTime,
    this.customerName,
    this.customerTckn,
    this.customerPhone,
    this.starterUser,
    this.ikaStarterUser,
    this.signUser,
    this.ikaSignUser,
    this.checkUser,
    this.ikaCheckUser,
    this.ikaStartDateTime,
    this.signDateTime,
    this.ikaSignDateTime,
    this.checkDateTime,
    this.ikaCheckDateTime,
    this.tesStatu,
    this.ikaStatu,
    this.onlyTes,
    this.customerUid,
  });

  factory TesdocModel.fromDocument(Map<String, dynamic> data) {
    return TesdocModel(
      id: data["id"] ?? 0,
      dateTime: data["dateTime"] ?? '',
      customerName: data["customerName"] ?? '',
      customerTckn: data["customerTckn"] ?? '',
      customerPhone: data["customerPhone"] ?? '',
      starterUser: data["starterUser"] ?? '',
      ikaStarterUser: data["ikaStarterUser"] ?? '',
      signUser: data["signUser"] ?? '',
      ikaSignUser: data["ikaSignUser"] ?? '',
      checkUser: data["checkUser"] ?? '',
      ikaCheckUser: data["ikaCheckUser"] ?? '',
      ikaStartDateTime: data["ikaStartDateTime"] ?? '',
      signDateTime: data["signDateTime"] ?? '',
      ikaSignDateTime: data["ikaSignDateTime"] ?? '',
      checkDateTime: data["checkDateTime"] ?? '',
      ikaCheckDateTime: data["ikaCheckDateTime"] ?? '',
      tesStatu: data["tesStatu"] ?? '',
      ikaStatu: data["ikaStatu"] ?? '',
      onlyTes: data["onlyTes"] ?? true,
      customerUid: data["customerUid"] ?? "",
    );
  }

  TesdocModel fromJson(Map<String, dynamic> json) {
    return TesdocModel(
      id: json["id"],
      dateTime: json["dateTime"],
      customerName: json["customerName"],
      customerTckn: json["customerTckn"],
      customerPhone: json["customerPhone"],
      starterUser: json["starterUser"],
      ikaStarterUser: json["ikaStarterUser"],
      signUser: json["signUser"],
      ikaSignUser: json["ikaSignUser"],
      checkUser: json["checkUser"],
      ikaCheckUser: json["ikaCheckUser"],
      ikaStartDateTime: json["ikaStartDateTime"],
      signDateTime: json["signDateTime"],
      ikaSignDateTime: json["ikaSignDateTime"],
      checkDateTime: json["checkDateTime"],
      ikaCheckDateTime: json["ikaCheckDateTime"],
      tesStatu: json["tesStatu"],
      ikaStatu: json["ikaStatu"],
      onlyTes: json["onlyTes"],
      customerUid: json["customerUid"],
    );
  }

  Map<String, dynamic> toJson({bool? isUpdate = false}) {
    return {
      'id': id,
      'dateTime': dateTime,
      'customerName': customerName,
      'customerTckn': customerTckn,
      'customerPhone': customerPhone,
      'starterUser': starterUser,
      'ikaStarterUser': ikaStarterUser,
      'signUser': signUser,
      'ikaSignUser': ikaSignUser,
      'checkUser': checkUser,
      'ikaCheckUser': ikaCheckUser,
      'ikaStartDateTime': ikaStartDateTime,
      'signDateTime': signDateTime,
      'ikaSignDateTime': ikaSignDateTime,
      'checkDateTime': checkDateTime,
      'ikaCheckDateTime': ikaCheckDateTime,
      'tesStatu': tesStatu,
      'ikaStatu': ikaStatu,
      'onlyTes': onlyTes,
      'customerUid': customerUid,
    };
  }

  String finalDate() {
    if (dateTime != null && dateTime != "") {
      DateTime newDate = DateTime.parse(dateTime!);
      String day =
          newDate.day < 10 ? "0${newDate.day}" : newDate.day.toString();
      String month =
          newDate.month < 10 ? "0${newDate.month}" : newDate.month.toString();

      return "$day.$month.${newDate.year}";
    } else {
      return "";
    }
  }

  String finalIkaDate() {
    if (ikaStartDateTime != null && ikaStartDateTime != "") {
      DateTime newDate = DateTime.parse(ikaStartDateTime!);
      String day =
          newDate.day < 10 ? "0${newDate.day}" : newDate.day.toString();
      String month =
          newDate.month < 10 ? "0${newDate.month}" : newDate.month.toString();

      return "$day.$month.${newDate.year}";
    } else {
      return "";
    }
  }

  String finalsignDate() {
    if (signDateTime != null && signDateTime != "") {
      DateTime newDate = DateTime.parse(signDateTime!);
      String day =
          newDate.day < 10 ? "0${newDate.day}" : newDate.day.toString();
      String month =
          newDate.month < 10 ? "0${newDate.month}" : newDate.month.toString();

      return "$day.$month.${newDate.year}";
    } else {
      return "";
    }
  }

  String finalIkaSignDate() {
    if (ikaSignDateTime != null && ikaSignDateTime != "") {
      DateTime newDate = DateTime.parse(ikaSignDateTime!);
      String day =
          newDate.day < 10 ? "0${newDate.day}" : newDate.day.toString();
      String month =
          newDate.month < 10 ? "0${newDate.month}" : newDate.month.toString();

      return "$day.$month.${newDate.year}";
    } else {
      return "";
    }
  }

  String finalCheckDate() {
    if (checkDateTime != null && checkDateTime != "") {
      DateTime newDate = DateTime.parse(checkDateTime!);
      String day =
          newDate.day < 10 ? "0${newDate.day}" : newDate.day.toString();
      String month =
          newDate.month < 10 ? "0${newDate.month}" : newDate.month.toString();

      return "$day.$month.${newDate.year}";
    } else {
      return "";
    }
  }

  String finalIkaCheckDate() {
    if (ikaCheckDateTime != null && ikaCheckDateTime != "") {
      DateTime newDate = DateTime.parse(ikaCheckDateTime!);
      String day =
          newDate.day < 10 ? "0${newDate.day}" : newDate.day.toString();
      String month =
          newDate.month < 10 ? "0${newDate.month}" : newDate.month.toString();

      return "$day.$month.${newDate.year}";
    } else {
      return "";
    }
  }

  TesdocEnums tesStatuEnum() {
    switch (tesStatu) {
      case "0":
        return TesdocEnums.none;
      case "1":
        return TesdocEnums.start;
      case "2":
        return TesdocEnums.signed;
      case "3":
        return TesdocEnums.checked;
    }
    throw TesdocEnums.none;
  }

  TesdocEnums ikaStatuEnum() {
    switch (ikaStatu) {
      case "0":
        return TesdocEnums.none;
      case "1":
        return TesdocEnums.start;
      case "2":
        return TesdocEnums.signed;
      case "3":
        return TesdocEnums.checked;
    }
    throw TesdocEnums.none;
  }
}
