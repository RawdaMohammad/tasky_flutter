import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/sharedControllers/task_controller.dart';

class AchievedTasksWidget extends StatelessWidget {
  const AchievedTasksWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(
      builder: (BuildContext context,TaskController controller, Widget? child) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Achieved Tasks',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 4),
                  Text(
                    '${controller.totalDoneTasks} Out of ${controller.totalTask} Done',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Transform.rotate(
                    angle: -pi / 2,
                    child: SizedBox(
                      height: 48,
                      width: 48,
                      child: CircularProgressIndicator(
                        value: controller.percent,
                        backgroundColor: Color(0xFF6D6D6D),
                        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF15B86C)),
                        strokeWidth: 4,
                      ),
                    ),
                  ),
                  Text(
                    "${((controller.percent * 100).toInt())}%",
                    style: Theme.of(context).textTheme.titleMedium,
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
