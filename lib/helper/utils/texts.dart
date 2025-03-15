class Texts {
  static const String fronstImgPath =
      "https://fastly.picsum.photos/id/704/200/300.jpg?hmac=L0hDmSHSy2cciN8xRC5-EgnjSOLcurqToggugp9Deng";
  static const String backImgPath =
      "https://firebasestorage.googleapis.com/v0/b/saglamuglumuhasebe.appspot.com/o/back.png?alt=media&token=3491c663-a709-4acb-9c22-e41faf9db52a";
  static const String errCustomerAddedBefore = "Müşteri daha önce eklenmiş";
  static const String errFillTheBlanks = "Tüm zorunlu alanları doldurunuz";
  static const String nameSurnem = "Ad Soyad";
  static const String adress = "Adres";
  static const String phone = "Telefon";
  static const String placeOfBirth = "Doğum Yeri";
  static const String job = "Meslek";
  static const String iban = "IBAN";
  static const String motherName = "Anne Adı";
  static const String fatherName = "Baba Adı";
  static const String dateOfBirth = "Doğum Tarihi";
  static const String msgCustomerAdded = "Müşteri bilgileri kaydedildi.";
  static const String btnCustomerAdd = "Müşteri Ekle";
  static const String hdrDeliveryDocs =
      "KIYMETLİ MADEN ALIM SATIMINA İLİŞKİN TESLİM TESELLÜM BELGESİ";
  static const String cmpSaglam = "SAĞLAMOĞLU ALTIN MÜC.TUR.İNŞ.SAN.VE TİC.A.Ş";
  static const String cmpElmina = "ELMİNA HEDİYELİK EŞYA TİC. SAN. LTD. ŞTİ";

  static String companyCode(String companyName) {
    switch (companyName) {
      case "Sağlamoğlu Altın":
        return "saglamoglu_altin";
      case "Elmina Hediyelik Eşya":
        return "elmina";
      case "Sağlamoğlu Yetkili Müessese":
        return "yetkili";
      case "Sağlamoğlu Kıymetli Madenler":
        return "kiymetli";

      default:
        return "";
    }
  }
}
