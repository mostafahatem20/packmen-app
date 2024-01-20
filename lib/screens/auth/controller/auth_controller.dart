import 'dart:io';

import 'package:packmen_app/screens/auth/storage/user_storage.dart';

import '/core/app_export.dart';
import 'package:packmen_app/screens/auth/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:packmen_app/widgets/custom_snackbar.dart';

class AuthController extends BaseController {
  Rx<bool> isPasswordHidden = true.obs;
  Rx<bool> isPasswordHiddenR = true.obs;
  Rx<bool> isConfirmPasswordHiddenR = true.obs;
  Rx<bool> isLoading = false.obs;
  Rx<UserModel> user = UserModel().obs;
  RxString token = ''.obs;
  TextEditingController emailControllerL = TextEditingController();
  TextEditingController passwordControllerL = TextEditingController();
  TextEditingController userNameR = TextEditingController();
  TextEditingController userEmailR = TextEditingController();
  TextEditingController userPhoneNumberR = TextEditingController();
  TextEditingController userPasswordR = TextEditingController();
  TextEditingController userPasswordConfirmR = TextEditingController();

  togglePasswordVisibility() => isPasswordHidden.toggle();
  togglePasswordRVisibility() => isPasswordHiddenR.toggle();
  toggleConfirmPasswordRVisibility() => isConfirmPasswordHiddenR.toggle();

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  @override
  void onClose() {
    super.onClose();
    emailControllerL.dispose();
    passwordControllerL.dispose();
    userNameR.dispose();
    userEmailR.dispose();
    userPhoneNumberR.dispose();
    userPasswordR.dispose();
    userPasswordConfirmR.dispose();
  }

  String? userNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "validateUserNameField".tr;
    }
    if (!GetUtils.hasMatch(value, r'^[a-zA-Z\s]+$')) {
      return "userNameValidation".tr;
    }
    return null;
  }

  String? phoneNumberValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }
    if (GetUtils.isPhoneNumber(value)) {
      return null;
    }
    return "invalidPhoneNumberErrorMsg".tr;
  }

  String? emailValidator(String? value) {
    if (GetUtils.isEmail(value!)) {
      return null;
    }
    return "invalidEmailErrorMsg".tr;
  }

  String? passwordValidator(String? value) {
    if (isValidPassword(value!, isRequired: true)) {
      return null;
    }
    return "weakPassword".tr;
  }

  String? confirmPasswordValidator(String? value) {
    if (value == userPasswordR.value.text) {
      return null;
    }
    return "passwordMismatchErrorMsg".tr;
  }

  Future<void> login() async {
    try {
      isLoading.value = true;
      Map<String, String> requestBody = {
        "email": emailControllerL.value.text,
        "password": passwordControllerL.value.text,
      };
      String body = json.encode(requestBody);
      final response = await post('/auth/login', body);
      if (response.statusCode == HttpStatus.created) {
        final newToken = response.body["token"];
        final result = UserModel.fromJson(response.body["user"]);
        user.value = result;
        token.value = newToken;
        await UserStorage.saveUser(result);
        await UserStorage.saveToken(newToken);
        Get.offAllNamed(AppRoutes.homeScreen);
      } else {
        CustomSnackBar.showCustomErrorSnackBar(
            title: 'internalServerError'.tr, message: 'contactSupport'.tr);
      }
    } catch (e) {
      Logger.log(e);
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'internalServerError'.tr, message: 'contactSupport'.tr);
    } finally {
      isLoading.value = false;
    }
  }

  void getUser() {
    try {
      user.value = UserStorage.getUser() ?? UserModel();
      token.value = UserStorage.getToken() ?? '';
    } catch (e) {
      Logger.log(e);
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'internalServerError'.tr, message: 'contactSupport'.tr);
    }
  }

  Future<void> logout() async {
    await UserStorage.removeUser();
    await UserStorage.removeToken();
    user.value = UserModel();
    Get.offAllNamed(AppRoutes.loginScreen);
  }

  // Future<void> register() async {
  //   try {
  //     isLoading.value = true;
  //     Map<String, String> requestBody = {
  //       "email": userEmailR.value.text,
  //       "password": userPasswordR.value.text,
  //       "name": userNameR.value.text,
  //       "phoneNumber": userPhoneNumberR.value.text
  //     };
  //     requestBody.removeWhere((key, value) => value.isEmpty);
  //     String body = json.encode(requestBody);
  //     final response = await post('/auth/register', body);
  //     if (response.statusCode == HttpStatus.created) {
  //       clearRegistrationForm();
  //       // Get.toNamed(AppRoutes.loginScreen);
  //     } else {
  //       final error = ErrorModel.fromJson(response.body);
  //       CustomSnackBar.showCustomErrorSnackBar(
  //           title: 'regFailed'.tr, message: error.message!);
  //     }
  //   } catch (e) {
  //     Logger.log(e);
  //     CustomSnackBar.showCustomErrorSnackBar(
  //         title: 'internalServerError'.tr, message: 'contactSupport'.tr);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  clearRegistrationForm() {
    userEmailR.clear();
    userPasswordR.clear();
    userNameR.clear();
    userPhoneNumberR.clear();
  }
}
