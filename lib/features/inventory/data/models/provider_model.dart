class Provider {
  final int id;
  final String firstName;
  final String lastName;

  Provider({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }

  String get fullName => "$firstName $lastName";
}