import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/components/task_list_widget.dart';

import '../../core/sharedControllers/task_controller.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskController>(
      create: (context) => TaskController()..init(),
      child: Consumer(builder:
          (BuildContext context, TaskController taskController, Widget? child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'To Do Tasks',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: taskController.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : TaskListWidget(
                        tasks: taskController.toDoTasks,
                        onTap: (value, index) async {
                          taskController.doneTask(value, index);
                        },
                        emptyMessage: 'No Task Found',
                        onDelete: (int? id) {
                          taskController.deleteTask(id);
                        },
                        onEdit: () {
                          taskController.loadTask();
                        },
                      ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
