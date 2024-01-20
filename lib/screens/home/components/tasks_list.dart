import 'package:flutter/material.dart';
import 'package:packmen_app/core/app_export.dart';
import 'package:packmen_app/screens/home/controller/home_controller.dart';

class TasksList extends GetView<HomeController> {
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = context.width;

    return Scaffold(
      backgroundColor: HexColor('#f5f5f4'),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                margin: const EdgeInsets.only(top: 32),
                child: Text(
                  "Tasks",
                  style: TextStyle(
                    fontFamily: "NexaBold",
                    fontSize: screenWidth / 18,
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
