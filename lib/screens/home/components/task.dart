import 'package:flutter/material.dart';
import 'package:packmen_app/core/app_export.dart';
import 'package:packmen_app/screens/home/controller/home_controller.dart';

class Task extends GetView<HomeController> {
  final int index;
  final void Function() onBack;
  const Task({super.key, required this.index, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#f5f5f4'),
        body: Container(
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
              Text('$index'),
            ],
          ),
        ));
  }
}
