import 'package:flutter/material.dart';
import 'package:packmen_app/core/app_export.dart';
import 'package:packmen_app/screens/home/controller/home_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:packmen_app/widgets/custom_snackbar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class Task extends GetView<HomeController> {
  final int index;
  final void Function() onBack;
  const Task({super.key, required this.index, required this.onBack});
  static final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    final task = controller.getNotDoneTasks()[index];
    final screenWidth = context.width;
    return Scaffold(
      backgroundColor: HexColor('#f5f5f4'),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Obx(
            () => ListView(
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
                if (task['type'] == 'box') ..._buildBox(task, screenWidth),
                if (task['type'] == 'parcel')
                  ..._buildParcel(task, screenWidth),
                if (task['type'] == 'bike') ..._buildBike(task),
              ],
            ),
          )),
    );
  }

  Widget _buildScanner(void Function(int) onScan, double screenWidth) {
    return SizedBox(
      width: screenWidth,
      height: 500,
      child: Column(
        children: [
          Expanded(
            child: QRView(
              key: qrKey,
              onQRViewCreated: (controller) {
                _onQRViewCreated(controller, onScan);
              },
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScannerPlaceholder(String s, double screenWidth) {
    return Center(
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
                  s,
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
    );
  }

  List<Widget> _buildBox(dynamic task, double screenWidth) {
    if (controller.door.value == false) {
      return [
        Container(
          margin: const EdgeInsets.only(top: 24, bottom: 12),
          child: Builder(
            builder: (context) {
              final GlobalKey<SlideActionState> key = GlobalKey();

              return SlideAction(
                text: "Slide to Open door",
                textStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: screenWidth / 20,
                  fontFamily: "NexaRegular",
                ),
                outerColor: Colors.white,
                innerColor: AppTheme.themeColor,
                key: key,
                onSubmit: () async {
                  controller.setDoor(true);
                },
              );
            },
          ),
        )
      ];
    } else {
      return [
        const Text(
          "OffLoading Boxes: ",
        ),
        const SizedBox(height: 10),
        ...task['boxes'].map((e) {
          if (e['action'] == "off-load") {
            return CheckboxListTile(
              value: e['status'] == "Done",
              onChanged: (bool? value) {},
              enabled: false,
              title: Text(e['name']),
              activeColor: AppTheme.themeColor,
            );
          }
          return const SizedBox();
        }),
        const SizedBox(height: 10),
        const Text(
          "OnLoading Boxes: ",
        ),
        const SizedBox(height: 10),
        ...task['boxes'].map((e) {
          if (e['action'] == "on-load") {
            return CheckboxListTile(
              value: e['status'] == "Done",
              onChanged: (bool? value) {},
              enabled: false,
              title: Text(e['name']),
              activeColor: AppTheme.themeColor,
            );
          }
          return const SizedBox();
        }),
        const SizedBox(height: 10),
        if (controller.scan.value)
          _buildScanner((i) {
            controller.setStatus(0, 'boxes', i, 'Done');
          }, screenWidth)
        else if (task['boxes'].every((box) => box['status'] == 'Done'))
          GestureDetector(
            onTap: () {
              controller.setDoor(false);
              controller.setTaskStatus(0);
              onBack();
            },
            child: Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppTheme.themeColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Confirm',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
          )
        else
          _buildScannerPlaceholder('Scan Box', screenWidth)
      ];
    }
  }

  List<Widget> _buildParcel(dynamic task, double screenWidth) {
    return [
      ...task['parcels'].map((e) {
        return CheckboxListTile(
          value: e['status'] == "Done",
          onChanged: (bool? value) {},
          enabled: false,
          title: Text('Move ${e['name']} from ${e['from']} to ${e['to']}'),
          activeColor: AppTheme.themeColor,
        );
      }),
      const SizedBox(height: 10),
      if (controller.scan.value)
        _buildScanner((i) {
          controller.setStatus(1, 'parcels', i, 'Done');
        }, screenWidth)
      else if (task['parcels'].every((box) => box['status'] == 'Done'))
        GestureDetector(
          onTap: () {
            controller.setTaskStatus(1);
            onBack();
          },
          child: Container(
            width: double.infinity,
            height: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppTheme.themeColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Text(
              'Confirm',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        )
      else
        _buildScannerPlaceholder('Scan Parcel', screenWidth)
    ];
  }

  List<Widget> _buildBike(dynamic task) {
    // TODO: when task is a model we can refresh its state correctly
    print(controller.trigger.value);
    return [
      const Text(
        "Load on Bike: ",
      ),
      const SizedBox(height: 10),
      ...task['boxes'].map((e) {
        return CheckboxListTile(
          value: e['status'] == "Done",
          onChanged: (bool? value) {
            if (value == true) {
              controller.setStatus(2, 'boxes', e['id'], 'Done');
            } else {
              controller.setStatus(2, 'boxes', e['id'], 'Pending');
            }
            controller.toggleTrigger();
          },
          title: Text(e['name']),
          activeColor: AppTheme.themeColor,
        );
      }),
      const SizedBox(height: 10),
      GestureDetector(
        onTap: () {
          if (task['boxes'].every((box) => box['status'] == 'Done')) {
            controller.setTaskStatus(2);
            onBack();
          } else {
            CustomSnackBar.showCustomErrorSnackBar(
                title: 'Error', message: 'Please load all boxes on bike');
          }
        },
        child: Container(
          width: double.infinity,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.themeColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Confirm',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
      )
    ];
  }

  void _onQRViewCreated(
      QRViewController scanController, void Function(int) onScan) {
    scanController.scannedDataStream.listen((scanData) {
      String idStr = scanData.code ?? '';
      int scannedId = int.tryParse(idStr) ?? -1;
      onScan(scannedId);
      controller.setScan(false);
    });
  }
}
