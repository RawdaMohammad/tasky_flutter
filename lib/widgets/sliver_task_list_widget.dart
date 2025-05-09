import 'package:flutter/material.dart';
import 'package:tasky/models/task_model.dart';
import 'package:tasky/widgets/task_item_widget.dart';

class SliverTaskListWidget extends StatelessWidget {
  const SliverTaskListWidget({
    super.key,
    required this.tasks,
    required this.onTap,
    required this.onDelete,
    required this.onEdit,
    this.emptyMessage,
  });

  final List<TaskModel> tasks;
  final Function(bool?, int?) onTap;
  final Function(int?) onDelete;
  final Function onEdit;
  final String? emptyMessage;

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? SliverToBoxAdapter(
            child: Center(
              child: Text(
                emptyMessage ?? 'No Data',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
          )
        : SliverPadding(
            padding: EdgeInsets.only(bottom: 80),
            sliver: SliverList.separated(
              itemCount: tasks.length,
              itemBuilder: (BuildContext context, int index) {
                return TaskItemWidget(
                  model: tasks[index],
                  onChanged: (bool? value) {
                    onTap(value, index);
                  },
                  onDelete: (int id) {
                    onDelete(id);
                  },
                  onEdit: () => onEdit(),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8);
              },
            ),
          );
  }
}
