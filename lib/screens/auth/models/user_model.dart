class UserModel {
  int? id;
  String? role;
  String? email;

  UserModel({
    this.id,
    this.role,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'], role: json['role'], email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'role': role,
      'email': email,
    };
  }

  Map<String, dynamic> toRequestBody() {
    return {
      'email': email,
    };
  }
}
