import 'package:flutter/material.dart';
import 'package:packmen_app/core/app_export.dart';
import 'package:packmen_app/screens/auth/controller/auth_controller.dart';
import 'package:packmen_app/widgets/authentication_layout.dart';
import 'package:packmen_app/widgets/text_field.dart';

class Register extends GetView<AuthController> {
  const Register({super.key});

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
          onMainButtonTapped: () {},
          title: 'Create Account',
          subtitle:
              'Enter your name, phone number, email and password for sign up',
          mainButtonTitle: 'SIGN UP',
          form: Column(
            children: [
              CustomTextField(
                labelText: 'Full Name',
                controller: controller.userNameR,
                validator: controller.userNameValidator,
                prefixIcon: Icon(
                  Icons.person_outline,
                  color: AppTheme.themeColor,
                  size: 28.sp,
                ),
              ),
              SizedBox(height: 15.h),
              CustomTextField(
                keyboardType: TextInputType.emailAddress,
                labelText: 'Email',
                controller: controller.userEmailR,
                validator: controller.emailValidator,
                prefixIcon: Icon(
                  Icons.email,
                  color: AppTheme.themeColor,
                  size: 28.sp,
                ),
              ),
              SizedBox(height: 15.h),
              CustomTextField(
                labelText: 'Phone Number',
                prefixIcon: Icon(
                  Icons.phone,
                  color: AppTheme.themeColor,
                  size: 28.sp,
                ),
                controller: controller.userPhoneNumberR,
                validator: controller.phoneNumberValidator,
              ),
              SizedBox(height: 15.h),
              Obx(() => CustomTextField(
                    labelText: 'Password',
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: AppTheme.themeColor,
                      size: 28.sp,
                    ),
                    controller: controller.userPasswordR,
                    obscureText: controller.isPasswordHiddenR.value,
                    suffixIcon: InkWell(
                      onTap: () {
                        controller.togglePasswordRVisibility();
                      },
                      child: Icon(
                        controller.isPasswordHiddenR.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppTheme.themeColor,
                        size: 22.sp,
                      ),
                    ),
                    validator: controller.passwordValidator,
                  )),
              SizedBox(height: 15.h),
              Obx(() => CustomTextField(
                    labelText: 'Confirm Password',
                    prefixIcon: Icon(
                      Icons.lock_outline,
                      color: AppTheme.themeColor,
                      size: 28.sp,
                    ),
                    controller: controller.userPasswordConfirmR,
                    obscureText: controller.isConfirmPasswordHiddenR.value,
                    suffixIcon: InkWell(
                      onTap: () {
                        controller.toggleConfirmPasswordRVisibility();
                      },
                      child: Icon(
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppTheme.themeColor,
                        size: 22.sp,
                      ),
                    ),
                    validator: controller.confirmPasswordValidator,
                  )),
            ],
          ),
          showTermsText: true,
        ));
  }
}
