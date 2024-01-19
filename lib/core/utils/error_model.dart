class ErrorModel {
  int? statusCode;
  String? message;

  ErrorModel({
    this.statusCode,
    this.message,
  });

  ErrorModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    message = json['message'];
  }
}
