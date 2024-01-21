import 'dart:io';

import 'package:packmen_app/widgets/custom_snackbar.dart';

import 'package:packmen_app/core/app_export.dart';

class HomeController extends BaseController {
  Rx<bool> isLoading = false.obs;
  Rx<bool> scan = false.obs;
  Rx<bool> door = false.obs;
  RxString checkIn = "--/--".obs;
  RxString checkOut = "--/--".obs;
  Rx<bool> trigger = false.obs;
  toggleTrigger() => trigger.toggle();

  RxList<Map<String, Object>> tasks = [
    {
      'title': 'OffLoading & OnLoading boxes',
      'time': '07:00',
      'boxes': [
        {
          'id': 1,
          'name': 'DHL XXYYZZ',
          'action': 'off-load',
          'status': 'Pending'
        },
        {
          'id': 2,
          'name': 'GLS ZZYYXX',
          'action': 'off-load',
          'status': 'Pending'
        },
        {
          'id': 3,
          'name': 'UPS AABBCD',
          'action': 'on-load',
          'status': 'Pending'
        },
        {
          'id': 4,
          'name': 'FedEx CCDDEE',
          'action': 'on-load',
          'status': 'Pending'
        }
      ],
      'status': 'Active',
      'type': 'box'
    },
    {
      'title': 'Sorting Parcels',
      'time': '08:00',
      'parcels': [
        {
          'id': 1,
          'name': 'DHL XXYYZZ',
          'status': 'Pending',
          'from': 'B1',
          'to': 'B2'
        },
        {
          'id': 2,
          'name': 'GLS ZZYYXX',
          'status': 'Done',
          'from': 'B1',
          'to': 'B2'
        },
        {
          'id': 3,
          'name': 'UPS AABBCD',
          'action': 'on-load',
          'status': 'Pending',
          'from': 'B1',
          'to': 'B2'
        },
        {
          'id': 4,
          'name': 'FedEx CCDDEE',
          'status': 'Done',
          'from': 'B1',
          'to': 'B2'
        }
      ],
      'status': 'Active',
      'type': 'parcel'
    },
    {
      'title': 'Bike Delivery',
      'time': '09:00',
      'boxes': [
        {'id': 1, 'name': 'DHL XXYYZZ', 'status': 'Pending'},
        {'id': 2, 'name': 'GLS ZZYYXX', 'status': 'Pending'},
        {'id': 3, 'name': 'UPS AABBCD', 'status': 'Pending'},
        {'id': 4, 'name': 'FedEx CCDDEE', 'status': 'Pending'}
      ],
      'status': 'current',
      'type': 'bike'
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

  void setScan(bool v) {
    scan.value = v;
  }

  void setDoor(bool v) {
    door.value = v;
  }

  void setCheckOut() {
    checkOut.value = DateFormat('hh:mm').format(DateTime.now());
  }

  void setStatus(int index, String field, int id, String status) {
    final task = tasks[index];
    if (!task.containsKey(field)) {
      Logger.log('Error: field $field not found in task');
      return;
    }
    final boxes = task[field] as List;
    final box = boxes.firstWhere((box) => box['id'] == id);
    if (box == null) {
      Logger.log('Error: box with id $id not found in task');
      return;
    }
    if (box['status'] == 'Done') {
      CustomSnackBar.showCustomErrorSnackBar(
          title: 'Error', message: 'This box/parcel already scanned');
      return;
    }
    box['status'] = status;
  }

  void setTaskStatus(int index) {
    if (index < 0 || index >= tasks.length) {
      Logger.log('Error: invalid index $index');
      return;
    }
    ;
    tasks[index]['status'] = 'Done';
  }

  List<Map<String, Object>> getNotDoneTasks() {
    return tasks.where((task) => task['status'] != 'Done').toList();
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
