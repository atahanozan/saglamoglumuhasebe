enum TesdocEnums {
  none,
  start,
  signed,
  checked,
}

extension TesdocEnumExtensions on TesdocEnums {
  String get displayName {
    switch (this) {
      case TesdocEnums.none:
        return "Henüz Başlanmadı";
      case TesdocEnums.start:
        return "Şubeye Gönderildi";
      case TesdocEnums.signed:
        return "İmzalandı";
      case TesdocEnums.checked:
        return "Kontrol Edildi";
    }
  }
}
