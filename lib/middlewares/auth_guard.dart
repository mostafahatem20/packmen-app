import 'package:flutter/material.dart';
import 'package:packmen_app/core/app_export.dart';
import 'package:packmen_app/screens/auth/controller/auth_controller.dart';

class AuthGuard extends GetMiddleware {
  final controller = Get.put(AuthController());
  @override
  int? get priority => 1;

  @override
  RouteSettings? redirect(String? route) {
    if (controller.token.value == '') {
      return const RouteSettings(name: AppRoutes.loginScreen);
    }
    return null;
  }
}
