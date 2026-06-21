class Supplier {
  final int id;
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String ruc;

  Supplier({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.ruc,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      phone: json["phone"],
      email: json["email"],
      ruc: json["ruc"],
    );
  }
}