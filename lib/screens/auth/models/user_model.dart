class UserModel {
  int? id;
  String? name;
  String? email;
  String? image;
  String? phoneNumber;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.image,
    this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        image: json['image'],
        phoneNumber: json['phoneNumber']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'phoneNumber': phoneNumber,
    };
  }

  Map<String, dynamic> toRequestBody() {
    return {
      'name': name,
      'email': email,
      'image': image,
      'phoneNumber': phoneNumber,
    };
  }
}
