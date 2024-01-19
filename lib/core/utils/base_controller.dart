import 'dart:io';
import 'package:packmen_app/core/app_export.dart';

class BaseController extends GetConnect implements GetxService {
  @override
  void onInit() {
    httpClient.baseUrl =
        GetPlatform.isWeb ? Constants.apiWebURL : Constants.apiBaseURL;
    httpClient.addRequestModifier<Object?>((request) async {
      request.headers[HttpHeaders.contentTypeHeader] = 'application/json';
      request.headers[HttpHeaders.acceptHeader] = 'application/json';
      request.headers[HttpHeaders.authorizationHeader] = 'Bearer ';
      return request;
    });
  }
}
