import 'dart:io';

import 'package:packmen_app/widgets/custom_snackbar.dart';

import 'package:packmen_app/core/app_export.dart';

class HomeController extends BaseController {
  Rx<bool> isLoading = false.obs;
  RxString checkIn = "--/--".obs;
  RxString checkOut = "--/--".obs;
  // @override
  // void onInit() {
  //   super.onInit();
  //   getTasks();
  // }

  void setCheckIn() {
    checkIn.value = DateFormat('hh:mm').format(DateTime.now());
  }

  void setCheckOut() {
    checkOut.value = DateFormat('hh:mm').format(DateTime.now());
  }

  Future<void> getTasks() async {
    try {
      isLoading.value = true;
      final response = await get('/transactions/report');
      if (response.statusCode == HttpStatus.ok) {
        // final result = DashboardReportModel.fromJson(response.body);
        // report.value = result;
      } else {
        final error = ErrorModel.fromJson(response.body);
        CustomSnackBar.showCustomErrorSnackBar(
            title: 'error'.tr, message: error.message!);
      }
    } catch (e) {
      Logger.log(e);
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'internalServerError'.tr, message: 'contactSupport'.tr);
    } finally {
      isLoading.value = false;
    }
  }
}
