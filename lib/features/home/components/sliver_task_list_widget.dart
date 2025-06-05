import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/components/task_item_widget.dart';
import 'package:tasky/core/sharedControllers/task_controller.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskController>(
      builder: (BuildContext context, TaskController controller, Widget? child) {
        final tasksList = controller.tasks;
        return controller.isLoading
            ? SliverToBoxAdapter(
                child: Center(
                    child: CircularProgressIndicator(
                  value: 20,
                )),
              )
            : controller.tasks.isEmpty
                ? SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No Data',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 21),
                      ),
                    ),
                  )
                : SliverPadding(
                    padding: EdgeInsets.only(bottom: 80),
                    sliver: SliverList.separated(
                      itemCount: tasksList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return TaskItemWidget(
                          model: tasksList[index],
                          onChanged: (bool? value) {
                            controller.doneTask(value, index);
                          },
                          onDelete: (int id) {
                            controller.deleteTask(id);
                          },
                          onEdit: () => controller.loadTask(),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 8);
                      },
                    ),
                  );
      },
    );
  }
}
