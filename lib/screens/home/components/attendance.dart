import 'dart:async';
import 'package:flutter/material.dart';
import 'package:packmen_app/core/app_export.dart';
import 'package:packmen_app/screens/home/controller/home_controller.dart';

class Attendance extends GetView<HomeController> {
  const Attendance({super.key});
  static const geoLocation = LatLng(48.10900083072216, 11.47356748280948);
  Future<void> _openGoogleMaps(LatLng location) async {
    final url =
        'https://www.google.com/maps/search/?api=1&query=${location.latitude},${location.longitude}';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = context.width;

    return Scaffold(
        backgroundColor: HexColor('#f5f5f4'),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Obx(
              () => Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 32),
                    child: Text(
                      "Welcome,",
                      style: TextStyle(
                        color: Colors.black54,
                        fontFamily: "NexaRegular",
                        fontSize: screenWidth / 20,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Mostafa Abdelrahman",
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            'You are assigned to station "Klinikum Großhadern"',
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _openGoogleMaps(geoLocation);
                          },
                          child: const Icon(
                            Icons.location_on,
                            color: AppTheme.themeColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 32),
                    child: Text(
                      "Today's Status",
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 32),
                    height: 150,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(2, 2),
                        ),
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Check In",
                                style: TextStyle(
                                  fontFamily: "NexaRegular",
                                  fontSize: screenWidth / 20,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                controller.checkIn.value,
                                style: TextStyle(
                                  fontFamily: "NexaBold",
                                  fontSize: screenWidth / 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Check Out",
                                style: TextStyle(
                                  fontFamily: "NexaRegular",
                                  fontSize: screenWidth / 20,
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                controller.checkOut.value,
                                style: TextStyle(
                                  fontFamily: "NexaBold",
                                  fontSize: screenWidth / 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: RichText(
                        text: TextSpan(
                          text: DateTime.now().day.toString(),
                          style: TextStyle(
                            color: AppTheme.themeColor,
                            fontSize: screenWidth / 18,
                            fontFamily: "NexaBold",
                          ),
                          children: [
                            TextSpan(
                              text: DateFormat(' MMMM yyyy')
                                  .format(DateTime.now()),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: screenWidth / 20,
                                fontFamily: "NexaBold",
                              ),
                            ),
                          ],
                        ),
                      )),
                  StreamBuilder(
                    stream: Stream.periodic(const Duration(seconds: 1)),
                    builder: (context, snapshot) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          DateFormat('hh:mm:ss a').format(DateTime.now()),
                          style: TextStyle(
                            fontFamily: "NexaRegular",
                            fontSize: screenWidth / 20,
                            color: Colors.black54,
                          ),
                        ),
                      );
                    },
                  ),
                  controller.checkOut.value == "--/--"
                      ? Container(
                          margin: const EdgeInsets.only(top: 24, bottom: 12),
                          child: Builder(
                            builder: (context) {
                              final GlobalKey<SlideActionState> key =
                                  GlobalKey();

                              return SlideAction(
                                text: controller.checkIn.value == "--/--"
                                    ? "Slide to Check In"
                                    : "Slide to Check Out",
                                textStyle: TextStyle(
                                  color: Colors.black54,
                                  fontSize: screenWidth / 20,
                                  fontFamily: "NexaRegular",
                                ),
                                outerColor: Colors.white,
                                innerColor: AppTheme.themeColor,
                                key: key,
                                onSubmit: () async {
                                  Timer(const Duration(milliseconds: 1500), () {
                                    if (controller.checkIn.value == "--/--") {
                                      controller.setCheckIn();
                                    } else {
                                      controller.setCheckOut();
                                    }
                                    key.currentState!.reset();
                                  });
                                },
                              );
                            },
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 32, bottom: 32),
                          child: Text(
                            "You have completed this day!",
                            style: TextStyle(
                              fontFamily: "NexaRegular",
                              fontSize: screenWidth / 20,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                ],
              ),
            )));
  }
}
