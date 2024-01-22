class UserModel {
  int? id;
  String? role;
  String? email;
  String? name;

  UserModel({this.id, this.role, this.email, this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        role: json['role'],
        email: json['email'],
        name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'role': role, 'email': email, 'name': name};
  }

  Map<String, dynamic> toRequestBody() {
    return {'email': email, 'name': name};
  }
}
