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
      return "This field is required!";
    }
    if (!GetUtils.hasMatch(value, r'^[a-zA-Z\s]+$')) {
      return "Only english alphabets are allowed";
    }
    return null;
  }

  String? phoneNumberValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "This field is required!";
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return "Phone number is not valid";
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (GetUtils.isEmail(value!)) {
      return null;
    }
    return "Email is not valid";
  }

  String? passwordValidator(String? value) {
    if (isValidPassword(value!, isRequired: true)) {
      return null;
    }
    return "Password is not strong enough";
  }

  String? confirmPasswordValidator(String? value) {
    if (value == userPasswordR.value.text) {
      return null;
    }
    return "Passwords do not match";
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
            title: 'Unauthorized', message: 'Invalid credentials.');
      }
    } catch (e) {
      Logger.log(e);
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Internal Server Error',
          message: 'Please contact an administrator');
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
          title: 'Internal Server Error',
          message: 'Please contact an administrator');
    }
  }

  Future<void> logout() async {
    await UserStorage.removeUser();
    await UserStorage.removeToken();
    user.value = UserModel();
    Get.offAllNamed(AppRoutes.loginScreen);
  }

  clearRegistrationForm() {
    userEmailR.clear();
    userPasswordR.clear();
    userNameR.clear();
    userPhoneNumberR.clear();
  }
}
