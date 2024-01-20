import 'dart:io';

import 'package:packmen_app/widgets/custom_snackbar.dart';

import 'package:packmen_app/core/app_export.dart';

class HomeController extends BaseController {
  Rx<bool> isLoading = false.obs;
  RxString checkIn = "--/--".obs;
  RxString checkOut = "--/--".obs;
  RxList<Map<String, Object>> tasks = [
    {
      'title': 'Load box',
      'time': '07:00',
      'slot': '07:00 - 8:00',
      'subtitle': 'Load a large box with the following parcels:',
      'ids': ['DHL XXYYZZ', 'GLS ZZYYXX', 'UPS AABBCD', 'FedEx CCDDEE'],
      'status': 'current',
      'boxSize': 'Large',
    },
    {
      'title': 'Load box',
      'time': '08:00',
      'slot': '08:00 - 9:00',
      'subtitle': 'Load a large box with the following parcels:',
      'ids': ['DHL XXYYZZ', 'GLS ZZYYXX', 'UPS AABBCD', 'FedEx CCDDEE'],
      'status': 'current',
      'boxSize': 'Large',
    },
    {
      'title': 'Load box',
      'time': '09:00',
      'slot': '09:00 - 10:00',
      'subtitle': 'Load a large box with the following parcels:',
      'ids': ['DHL XXYYZZ', 'GLS ZZYYXX', 'UPS AABBCD', 'FedEx CCDDEE'],
      'status': 'current',
      'boxSize': 'Large',
    },
    {
      'title': 'Load box',
      'time': '10:00',
      'slot': '10:00 - 11:00',
      'subtitle': 'Load a large box with the following parcels:',
      'ids': ['DHL XXYYZZ', 'GLS ZZYYXX', 'UPS AABBCD', 'FedEx CCDDEE'],
      'status': 'current',
      'boxSize': 'Large',
    },
    {
      'title': 'Load box',
      'time': '11:00',
      'slot': '11:00 - 12:00',
      'subtitle': 'Load a large box with the following parcels:',
      'ids': ['DHL XXYYZZ', 'GLS ZZYYXX', 'UPS AABBCD', 'FedEx CCDDEE'],
      'status': 'current',
      'boxSize': 'Large',
    },
    {
      'title': 'Load box',
      'time': '12:00',
      'slot': '12:00 - 13:00',
      'subtitle': 'Load a large box with the following parcels:',
      'ids': ['DHL XXYYZZ', 'GLS ZZYYXX', 'UPS AABBCD', 'FedEx CCDDEE'],
      'status': 'current',
      'boxSize': 'Large',
    },
    {
      'title': 'Load box',
      'time': '13:00',
      'slot': '13:00 - 14:00',
      'subtitle': 'Load a large box with the following parcels:',
      'ids': ['DHL XXYYZZ', 'GLS ZZYYXX', 'UPS AABBCD', 'FedEx CCDDEE'],
      'status': 'current',
      'boxSize': 'Large',
    },
  ].obs;
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
            title: 'Error', message: error.message!);
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
}
