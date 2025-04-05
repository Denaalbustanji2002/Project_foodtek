class UserModel {
  final int? id;
  final String name;
  final String email;
  final String? phone;
  final String? dateOfBirth;
  final String? createdAt;
  final String? token;
  final String? password;
  final String? password_Confirmation;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.phone,
    this.dateOfBirth,
    this.createdAt,
    this.token,
    this.password,
    required this.password_Confirmation,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['Id'] != null ? int.tryParse(json['Id'].toString()) ?? 0 : null,
      name: json['Name'] ?? "",
      email: json['Email'] ?? "",
      phone: json['phone_number'] ?? "",
      dateOfBirth: json['dob'] ?? "",
      createdAt: json['Created_at'] ?? "",
      token: json['Token'] ?? "",
      password: json['password'] ?? "",
      password_Confirmation: json['password_confirmation'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone_number': phone,
      'dob': dateOfBirth,
      'created_at': createdAt,
      'token': token,
      'password': password,
      'password_confirmation': password_Confirmation,
    };
  }
}
