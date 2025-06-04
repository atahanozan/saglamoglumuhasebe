class DeliveryDocsData {
  final String date;
  final String name;
  final String company;
  final String price;
  final String? agentName;
  final String? lastEditedDate;

  DeliveryDocsData({
    required this.date,
    required this.name,
    required this.company,
    required this.price,
    this.agentName,
    this.lastEditedDate,
  });

  factory DeliveryDocsData.fromDocument(Map<String, dynamic> data) {
    return DeliveryDocsData(
      date: data['date'],
      name: data['name'],
      company: data['company'],
      price: data['price'],
      agentName: data["agentName"],
      lastEditedDate: data["lastEditedDate"],
    );
  }
}
