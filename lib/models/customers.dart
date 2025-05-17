class Customers {
  String name;
  String tcknvkn;

  Customers({
    required this.name,
    required this.tcknvkn,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "tcknvkn": tcknvkn,
    };
  }
}
