import 'package:flutter/material.dart';
import 'package:packmen_app/core/app_export.dart';
import 'package:packmen_app/screens/home/components/task_timeline.dart';
import 'package:packmen_app/screens/home/controller/home_controller.dart';

class TasksList extends GetView<HomeController> {
  final void Function(int) onTaskClick;
  const TasksList({super.key, required this.onTaskClick});
  @override
  Widget build(BuildContext context) {
    double screenWidth = context.width;
    final tasks = controller.getNotDoneTasks();
    return Scaffold(
      backgroundColor: HexColor('#f5f5f4'),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 32, bottom: 32),
                alignment: Alignment.centerLeft,
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "Tasks",
                      style: TextStyle(
                        fontFamily: "NexaBold",
                        fontSize: screenWidth / 18,
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      tasks.isNotEmpty
                          ? 'You have ${tasks.length} tasks for today'
                          : "You have no tasks today!",
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TaskTimeline(
                      task: tasks[index],
                      onTaskClick: () {
                        onTaskClick(index);
                      },
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}
