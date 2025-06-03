import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:tasky/core/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/models/task_model.dart';

class TaskController with ChangeNotifier {

  List<TaskModel> tasks = [];
  List<TaskModel> toDoTasks = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> highPriorityTasks = [];

  String? username = "Default";
  String? userImagePath;
  bool isLoading = false;
  int totalTask = 0;
  int totalDoneTasks = 0;
  double percent = 0;


  init() {
    loadTask();
  }


  void loadTask() async {
    isLoading = true;

    final finalTask = PreferencesManager().getString(StorageKey.tasks);
    if (finalTask != null) {
      final taskAfterDecode = jsonDecode(finalTask) as List<dynamic>;
      tasks = taskAfterDecode.map((element) => TaskModel.fromJson(element)).toList();

      loadTaskWithFilters();
      calculatePercent();
    }

    isLoading = false;

    notifyListeners();
  }

  void loadTaskWithFilters() {
    // Handle completed tasks tasks
    completedTasks = tasks.where((e) => e.isDone).toList();

    // Handle high priority tasks
    highPriorityTasks = tasks.where((e) => e.isHighPriority).toList();

    // Handle to-do tasks
    toDoTasks = tasks.where((e) => !e.isDone).toList();
  }


  calculatePercent() {
    totalTask = tasks.length;
    totalDoneTasks = tasks.where((e) => e.isDone).length;
    percent = totalTask == 0 ? 0 : totalDoneTasks / totalTask;
  }

  doneTask(bool? value, int? index) async {
    tasks[index!].isDone = value ?? false;
    calculatePercent();

    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));

    loadTaskWithFilters();
    notifyListeners();
  }

  deleteTask(int? id) async {
    if (id == null) return;
    tasks.removeWhere((task) => task.id == id);
    calculatePercent();
    final updatedTask = tasks.map((element) => element.toJson()).toList();
    PreferencesManager().setString(StorageKey.tasks, jsonEncode(updatedTask));
    loadTaskWithFilters();
    notifyListeners();
  }
}
