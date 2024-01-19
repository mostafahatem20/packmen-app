import 'package:packmen_app/core/app_export.dart';
import 'package:packmen_app/screens/auth/binding/auth_binding.dart';
import 'package:packmen_app/screens/auth/login/login.dart';
import 'package:packmen_app/screens/auth/register/register.dart';
import 'package:packmen_app/screens/introduction_animation/introduction_animation_screen.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String loginScreen = '/login';
  static const String registerScreen = '/register';

  static List<GetPage> pages = [
    GetPage(
      name: initialRoute,
      page: () => const IntroductionAnimationScreen(),
    ),
    GetPage(
      name: loginScreen,
      page: () => const Login(),
      bindings: [
        AuthBinding(),
      ],
    ),
    GetPage(
      name: registerScreen,
      page: () => const Register(),
      bindings: [
        AuthBinding(),
      ],
    ),
  ];
}
