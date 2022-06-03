class Contato {
  final int? contact_id;
  final String name;
  final String? email;
  final String address;
  final String phone;
  final String? createdAt;
  final String? updatedAt;
  final int? user_id;

  Contato(
      {this.contact_id,
      required this.name,
      this.email,
      required this.address,
      required this.phone,
      this.createdAt,
      this.updatedAt,
      this.user_id});
}

Contato fromJson(Map<String, dynamic> json) {
  return Contato(
      name: json['name'], address: json['address'], phone: json['phone']);
}
