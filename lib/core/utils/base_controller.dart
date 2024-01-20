import 'dart:io';
import 'package:packmen_app/core/app_export.dart';
import 'package:packmen_app/screens/auth/storage/user_storage.dart';

class BaseController extends GetConnect implements GetxService {
  @override
  void onInit() {
    httpClient.baseUrl =
        GetPlatform.isWeb ? Constants.apiWebURL : Constants.apiBaseURL;
    httpClient.addRequestModifier<Object?>((request) async {
      final token = UserStorage.getToken() ?? '';
      request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      request.headers[HttpHeaders.acceptHeader] = 'application/json';
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer $token';
      return request;
    });
  }
}
