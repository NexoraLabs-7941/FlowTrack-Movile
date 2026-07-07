class Batch {
  final int id;
  final int productId;
  final String lot;
  final String receptionDate;
  final String expirationDate;

  Batch({
    required this.id,
    required this.productId,
    required this.lot,
    required this.receptionDate,
    required this.expirationDate,
  });


  factory Batch.fromJson(Map<String,dynamic> json){

    return Batch(
      id: json["id"] ?? 0,
      productId: json["productId"] ?? 0,
      lot: json["lot"] ?? "",
      receptionDate: json["receptionDate"] ?? "",
      expirationDate: json["expirationDate"] ?? "",
    );

  }
}