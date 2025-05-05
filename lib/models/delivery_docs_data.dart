class DeliveryDocsData {
  final String date;
  final String name;
  final String company;
  final String price;

  DeliveryDocsData({
    required this.date,
    required this.name,
    required this.company,
    required this.price,
  });

  factory DeliveryDocsData.fromDocument(Map<String, dynamic> data) {
    return DeliveryDocsData(
      date: data['date'],
      name: data['name'],
      company: data['company'],
      price: data['price'],
    );
  }
}
