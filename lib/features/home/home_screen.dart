import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/features/add_task/add_task_screen.dart';
import 'package:tasky/features/home/components/achieved_tasks_widget.dart';
import 'package:tasky/features/home/components/high_priority_tasks_widget.dart';
import 'package:tasky/features/home/components/sliver_task_list_widget.dart';
import 'package:tasky/core/sharedControllers/task_controller.dart';
import 'package:tasky/features/profile/profile_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskController()..init()),
        ChangeNotifierProvider(create: (_) => ProfileController()..init()),
      ],
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Selector<ProfileController, String?>(
                            selector: (context, ProfileController controller) => controller.userImagePath,
                            builder: (BuildContext context, String? userImagePath, Widget? child) {
                              return CircleAvatar(
                                backgroundImage: userImagePath == null
                                    ? AssetImage('assets/images/person.png')
                                    : FileImage(File(userImagePath)),
                              );
                            },
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Selector<ProfileController, String?>(
                                selector: (context, ProfileController controller) => controller.username,
                                builder: (BuildContext context, String? username, Widget? child) {
                                  return Text(
                                    "Good Evening, $username",
                                    style: Theme.of(context).textTheme.titleMedium,
                                  );
                                },
                              ),
                              Text(
                                "One task at a time. One step closer.",
                                style: Theme.of(context).textTheme.titleSmall,
                              )
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Yuhuu ,Your work Is',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Row(
                        children: [
                          Text(
                            'almost done ! ',
                            style: Theme.of(context).textTheme.displayLarge,
                          ),
                          CustomSvgPicture.withoutColor(path: 'assets/images/waving_hand.svg'),
                        ],
                      ),
                      SizedBox(height: 16),
                      AchievedTasksWidget(),
                      SizedBox(height: 8),
                      HighPriorityTasksWidget(),
                      Padding(
                        padding: const EdgeInsets.only(top: 24, bottom: 16),
                        child: Text(
                          'My Tasks',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                ),
                SliverTaskListWidget(),
              ],
            ),
          ),
          floatingActionButton: SizedBox(
            height: 44,
            child: Builder(
              builder: (BuildContext context) {
                return FloatingActionButton.extended(
                  onPressed: () async {
                    final bool? result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return AddTaskScreen();
                        },
                      ),
                    );

                    if (result != null && result) {
                      context.read<TaskController>().loadTask();
                    }
                  },
                  label: Text(
                    'Add New Task',
                  ),
                  icon: Icon(Icons.add),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                );
              },
            ),
          ),
        ),
    );
  }
}
