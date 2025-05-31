import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/sharedControllers/task_controller.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/core/components/task_list_widget.dart';

class HighPriorityScreen extends StatelessWidget {
  const HighPriorityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskController>(
      create: (context) => TaskController()..init(),
      child: Consumer(builder:
          (BuildContext context, TaskController taskController, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('High Priority Tasks'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: taskController.isLoading
                ? Center(child: CircularProgressIndicator())
                : TaskListWidget(
                    tasks: taskController.highPriorityTasks,
                    onTap: (value, index) async {
                      taskController.doneTask(value, index);
                      taskController.loadTask();
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
        );
      }),
    );
  }
}
