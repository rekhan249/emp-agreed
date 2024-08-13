/// Login Admin
class AdminUserModel {
  final String email;
  final String password;

  AdminUserModel({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory AdminUserModel.fromMap(Map<String, dynamic> map) {
    return AdminUserModel(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }
}

/// Model for Admin response
class ResponseAdmin {
  ResponseAdmin({
    required this.name,
    required this.email,
    required this.accessToken,
    required this.tokenType,
  });

  final String? name;
  final String? email;
  final String? accessToken;
  final String? tokenType;

  factory ResponseAdmin.fromJson(Map<String, dynamic> json) {
    return ResponseAdmin(
      name: json["name"],
      email: json["email"],
      accessToken: json["accessToken"],
      tokenType: json["token_type"],
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "accessToken": accessToken,
        "token_type": tokenType,
      };
}
