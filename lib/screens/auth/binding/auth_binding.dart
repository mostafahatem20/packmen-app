import 'package:packmen_app/core/app_export.dart';
import 'package:packmen_app/screens/auth/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
  }
}
