import 'package:flutter/material.dart';
import 'package:packmen_app/core/app_export.dart';
import 'package:packmen_app/screens/auth/controller/auth_controller.dart';
import 'package:packmen_app/widgets/authentication_layout.dart';
import 'package:packmen_app/widgets/text_field.dart';

class Login extends GetView<AuthController> {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final canBack = navigator!.canPop();
    return Scaffold(
        backgroundColor: HexColor('#f5f5f4'),
        body: AuthenticationLayout(
          onBackPressed: canBack
              ? () {
                  Get.back();
                }
              : null,
          onCreateAccountTapped: () {
            Get.toNamed(AppRoutes.registerScreen);
          },
          onMainButtonTapped: () {
            Get.offAllNamed(AppRoutes.homeScreen);
          },
          title: 'Welcome',
          subtitle: 'Enter your email address to log in.',
          mainButtonTitle: 'LOG IN',
          form: Column(
            children: [
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                labelText: 'Email',
                prefixIcon: Icon(
                  Icons.email,
                  color: AppTheme.themeColor,
                  size: 28.sp,
                ),
                controller: controller.emailControllerL,
              ),
              SizedBox(height: 15.h),
              Obx(() => CustomTextField(
                    labelText: 'Password'.tr,
                    obscureText: controller.isPasswordHidden.value,
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: AppTheme.themeColor,
                      size: 28.sp,
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        controller.togglePasswordVisibility();
                      },
                      child: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppTheme.themeColor,
                        size: 28.sp,
                      ),
                    ),
                    controller: controller.passwordControllerL,
                  )),
            ],
          ),
          onForgotPassword: () {},
        ));
  }
}
