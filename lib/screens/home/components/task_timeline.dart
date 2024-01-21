import 'package:flutter/material.dart';
import 'package:packmen_app/core/app_export.dart';
import 'package:timeline_tile/timeline_tile.dart';

class TaskTimeline extends StatelessWidget {
  final Map<String, dynamic> task;
  final void Function() onTaskClick;
  const TaskTimeline(
      {super.key, required this.task, required this.onTaskClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: HexColor('#f5f5f4'),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(children: [
        _buildTimeline(AppTheme.themeColor),
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task['time'],
              style: TextStyle(color: HexColor('#D0AD5E')),
            ),
            _buildCard(Colors.white, task['title'], task['status'])
          ],
        ))
      ]),
    );
  }

  Widget _buildCard(Color bgColor, String title, String status) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(5),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                children: [
                  const Text('Status: '),
                  const SizedBox(width: 8),
                  Text(
                    status,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            child: IconButton(
              onPressed: onTaskClick,
              icon: const Icon(
                Icons.arrow_forward_ios,
                color: AppTheme.themeColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeline(Color color) {
    return SizedBox(
      height: 80,
      width: 20,
      child: TimelineTile(
        alignment: TimelineAlign.manual,
        lineXY: 0,
        isFirst: true,
        indicatorStyle: IndicatorStyle(
            indicatorXY: 0,
            width: 15,
            indicator: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(width: 5, color: color)),
            )),
        afterLineStyle: LineStyle(thickness: 2, color: color),
      ),
    );
  }
}
