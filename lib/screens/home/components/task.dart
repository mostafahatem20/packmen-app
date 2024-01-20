import 'package:flutter/material.dart';
import 'package:packmen_app/core/app_export.dart';
import 'package:packmen_app/screens/home/controller/home_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Task extends GetView<HomeController> {
  final int index;
  final void Function() onBack;
  const Task({super.key, required this.index, required this.onBack});
  static final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final task = controller.tasks[index];
    final screenWidth = context.width;
    return Scaffold(
        backgroundColor: HexColor('#f5f5f4'),
        body: Obx(
          () => Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: onBack,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          color: HexColor('#D0AD5E'),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Back to Tasks List',
                          style: TextStyle(color: HexColor('#D0AD5E')),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        "Task: ",
                        style: TextStyle(
                          fontFamily: "NexaBold",
                          fontSize: screenWidth / 18,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        task['title'] as String,
                        style: TextStyle(
                          fontFamily: "NexaBold",
                          fontSize: screenWidth / 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(task['subtitle'] as String),
                  const SizedBox(height: 10),
                  ...(task['ids'] as List<String>).map((e) => Text(e)),
                  const SizedBox(height: 20),
                  if (controller.scan.value)
                    Expanded(
                      child: QRView(
                        key: qrKey,
                        onQRViewCreated: _onQRViewCreated,
                        overlay: QrScannerOverlayShape(
                          borderColor: Colors.red,
                          borderRadius: 10,
                          borderLength: 30,
                          borderWidth: 10,
                        ),
                      ),
                    )
                  else
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          controller.setScan(true);
                        },
                        child: Container(
                          height: screenWidth / 2,
                          width: screenWidth / 2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                offset: Offset(2, 2),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Stack(
                                alignment: Alignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.expand,
                                    size: 70,
                                    color: AppTheme.themeColor,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.camera,
                                    size: 25,
                                    color: AppTheme.themeColor,
                                  ),
                                ],
                              ),
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 8,
                                ),
                                child: Text(
                                  task['type'] == '1'
                                      ? "Scan Box"
                                      : "Scan Parcel",
                                  style: TextStyle(
                                    fontFamily: "NexaRegular",
                                    fontSize: screenWidth / 20,
                                    color: Colors.black54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (controller.checklist != null)
                    const SizedBox(
                      height: 20,
                    ),
                  if (controller.checklist != null)
                    Text(
                      "Checklist: ",
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                      ),
                    ),
                  if (controller.checklist != null)
                    const SizedBox(
                      height: 8,
                    ),
                  if (controller.checklist != null)
                    ...controller.checklist!.asMap().entries.map((entry) {
                      int index = entry.key;
                      String e = entry.value;

                      return CheckboxListTile(
                        value: controller.checklistBool![index],
                        onChanged: (bool? value) {
                          controller.toggleChecklistBool(index);
                        },
                        title: Text(e),
                        activeColor: AppTheme.themeColor,
                      );
                    }),
                  if (controller.checklist != null)
                    const SizedBox(
                      height: 20,
                    ),
                  if (controller.checklist != null)
                    GestureDetector(
                      onTap: onBack,
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppTheme.themeColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: false
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Confirm',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14),
                              ),
                      ),
                    ),
                ],
              )),
        ));
  }

  void _onQRViewCreated(QRViewController scanController) {
    scanController.scannedDataStream.listen((scanData) {
      String idStr = scanData.code ?? '';
      int scannedBoxId = int.tryParse(idStr) ?? -1;
      print(scannedBoxId);
      controller.setScan(false);
      controller.setChecklist();
    });
  }
}
