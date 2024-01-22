import 'dart:io';
import 'package:packmen_app/screens/home/models/task_model.dart';
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

  RxList tasks = [].obs;

  @override
  void onInit() {
    super.onInit();
    getTasks();
  }

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

  void setStatus(int? taskId, String field, int? id) {
    final task =
        tasks.firstWhereOrNull((element) => element.id == taskId) as TaskModel;
    if (field == 'boxes') {
      final box = task.boxes!.firstWhere((box) => box.id == id);
      if (box.done == true) {
        CustomSnackBar.showCustomErrorSnackBar(
            title: 'Error', message: 'This box is already scanned');
        return;
      }
      box.done = true;
    }
    if (field == 'parcels') {
      final parcel = task.parcels!.firstWhere((parcel) => parcel.id == id);
      if (parcel.done == true) {
        CustomSnackBar.showCustomErrorSnackBar(
            title: 'Error', message: 'This parcel is already scanned');
        return;
      }
      parcel.done = true;
    }
  }

  void setTaskStatus(int id) {
    final task = tasks.firstWhereOrNull((element) => element.id == id);
    task.done = true;
  }

  TaskModel moveTask() {
    return tasks.firstWhereOrNull((element) => element.type == 'move');
  }

  List<dynamic> getNotDoneTasks() {
    return tasks.where((task) => !task.done! && task.type != 'move').toList();
  }

  Future<void> getTasks() async {
    try {
      isLoading.value = true;
      final response = await get('/tasks');
      if (response.statusCode == HttpStatus.ok) {
        final data = response.body;
        final taskList = data.map((taskData) {
          return TaskModel.fromJson(taskData);
        }).toList();
        tasks.value = taskList;
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
