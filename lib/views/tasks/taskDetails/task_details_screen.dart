import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:TaskRM/providers/task_provider.dart';
import 'package:TaskRM/utils/color.dart';
import 'package:TaskRM/utils/spacer.dart';
import 'package:TaskRM/utils/typograpgy.dart';
import '../../../models/task.dart';
import '../../../utils/assets_path.dart';
import 'package:TaskRM/widgets/dialogs/add_time_dialog.dart';
import 'package:TaskRM/views/tasks/task_form_bottomsheet.dart';
import 'package:TaskRM/utils/custom_dialog.dart';
import 'package:powersync/powersync.dart' as powersync;
import '../../../powersync.dart';

class TaskDetailsScreen extends StatelessWidget {
  final Task initialTask;

  const TaskDetailsScreen({
    Key? key,
    required this.initialTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.watch(
        '''
        SELECT t.*, g.title as goal_title 
        FROM tasks t
        LEFT JOIN goals g ON t.goal_id = g.id
        WHERE t.id = ?
        ''',
        parameters: [initialTask.id.toString()],
      ),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final taskData = snapshot.data![0];
        final task = Task(
          id: taskData['id'],
          title: taskData['title'],
          type: taskData['type'],
          priority: taskData['priority'],
          description: taskData['description'],
          timeframe: taskData['timeframe'],
          goalId: taskData['goal_id'],
          goal: taskData['goal_title'],
          isCompleted: taskData['is_completed'] == 1 ? 1 : 0,
          expectedCompletion: taskData['expected_completion'],
        );

        return Scaffold(
          appBar: _buildAppBar(context, task),
          body: Column(
            children: [
              _buildTaskDetails(context, task),
              _buildBottomSheet(context, task),
            ],
          ),
        );
      },
    );
  }

  PreferredSize _buildAppBar(BuildContext context, Task task) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(60.0),
      child: AppBar(
        centerTitle: false,
        shape: Border(bottom: BorderSide(color: borderColor, width: 1)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task',
              style: tTextStyleRegular.copyWith(fontSize: 16, color: black),
            ),
            Text(
              task.title!,
              maxLines: 2,
              style: tTextStyleRegular.copyWith(fontSize: 14),
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            icon: SvgPicture.asset(menuIcon),
            offset: const Offset(0, 40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (BuildContext context) => [
              PopupMenuItem<String>(
                value: 'edit',
                child: Row(
                  children: [
                    const Icon(Icons.edit_outlined, color: textPrimaryColor, size: 20),
                    sixteenHorizontalSpace,
                    Text(
                      'Edit',
                      style: tTextStyle500.copyWith(
                        fontSize: 14,
                        color: textPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'delete',
                child: Row(
                  children: [
                    const Icon(Icons.delete_outline, color: Colors.red, size: 20),
                    sixteenHorizontalSpace,
                    Text(
                      'Delete',
                      style: tTextStyle500.copyWith(
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  CustomDialog.bottomSheet(
                    context,
                    TaskFormBottomSheet(task: task),
                  );
                  break;
                case 'delete':
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFF5F5F5),
                                ),
                                child: const Icon(
                                  Icons.delete_outline,
                                  color: textPrimaryColor,
                                  size: 24,
                                ),
                              ),
                              sixteenVerticalSpace,
                              Text(
                                'Delete task',
                                style: tTextStyle500.copyWith(
                                  fontSize: 20,
                                  color: textPrimaryColor,
                                ),
                              ),
                              eightVerticalSpace,
                              Text(
                                'Deleted items will be forever lost.\nAre you sure?',
                                textAlign: TextAlign.center,
                                style: tTextStyleRegular.copyWith(
                                  fontSize: 14,
                                  color: textSecondaryColor,
                                ),
                              ),
                              twentyFourVerticalSpace,
                              InkWell(
                                onTap: () async {
                                  final taskProvider = Provider.of<TaskProvider>(
                                    context, 
                                    listen: false
                                  );
                                  
                                  try {
                                    await taskProvider.deleteTask(task.id.toString());
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    }
                                  } catch (e) {
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content: Text('Failed to delete task'),
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(color: borderColor),
                                      bottom: BorderSide(color: borderColor),
                                    ),
                                  ),
                                  child: Text(
                                    'Delete',
                                    textAlign: TextAlign.center,
                                    style: tTextStyle500.copyWith(
                                      fontSize: 16,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  child: Text(
                                    'Cancel',
                                    textAlign: TextAlign.center,
                                    style: tTextStyle500.copyWith(
                                      fontSize: 16,
                                      color: textPrimaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                  break;
              }
            },
          ),
          sixteenHorizontalSpace,
        ],
      ),
    );
  }

  Widget _buildTaskDetails(BuildContext context, Task task) {
    return Expanded(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildInfoTile(context, typeIcon, 'Type', task.type!, false, task),
                primaryVerticalSpace,
                _buildInfoTile(context, priorityIcon, 'Priority', task.priority!, false, task),
                primaryVerticalSpace,
                _buildInfoTile(context, timeFrameIcon, 'Timeframe', task.timeframe!, false, task),
                primaryVerticalSpace,
                _buildInfoTile(context, descriptionIcon, 'Description', task.description!, false, task),
                primaryVerticalSpace,
                _buildInfoTile(context, goalIcon, 'Goal', task.goal!, true, task),
                primaryVerticalSpace,
                _buildInfoTile(context, scheduleIcon, 'Time spent', '', false, task),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(BuildContext context, String icon, String title, String content, bool isGoal, Task task) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(icon),
            const SizedBox(width: 4),
            Text(
              title,
              style: tTextStyle500.copyWith(
                fontSize: 14,
                color: isGoal ? primaryColor : const Color(0xFFAAAAAA),
              ),
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(icon, color: trans),
            const SizedBox(width: 4),
            if (title == 'Time spent')
              _buildTimeSpent(task.id.toString())
            else
              SizedBox(
                width: MediaQuery.of(context).size.width / 1.2,
                child: Text(
                  content,
                  style: tTextStyleRegular.copyWith(
                    fontSize: 16,
                    color: textColorBold,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimeSpent(String taskId) {
    return StreamBuilder(
      stream: db.watch(
        '''
        SELECT SUM(time_spent) as total_time
        FROM time_tracking
        WHERE task_id = ?
        ''',
        parameters: [taskId],
      ),
      builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (!snapshot.hasData) {
          return const Text('Calculating...');
        }

        final totalMinutes = snapshot.data![0]['total_time'] as int? ?? 0;
        final hours = totalMinutes ~/ 60;
        final minutes = totalMinutes % 60;
        
        if (hours > 0) {
          return Text('$hours hr ${minutes > 0 ? '$minutes min' : ''}');
        } else {
          return Text('$minutes min');
        }
      },
    );
  }

  Widget _buildBottomSheet(BuildContext context, Task task) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: borderColor),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _bottomButton(context, clearIcon, 'Remove from\nToday', false, task),
            _bottomButton(context, addTimeIcon, 'Add Time', false, task),
            _bottomButton(context, checkIcon, 'Complete Task', true, task),
          ],
        ),
      ),
    );
  }

  Widget _bottomButton(BuildContext context, String icon, String title, bool isComplete, Task task) {
    return InkWell(
      onTap: () async {
        if (isComplete) {
          // Show confirmation dialog
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Complete Task'),
              content: const Text('Are you sure you want to mark this task as complete?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context); // Close dialog
                    try {
                      await db.execute(
                        'UPDATE tasks SET is_completed = ? WHERE id = ?',
                        [task.isCompleted == 1 ? 0 : 1, task.id.toString()],
                      );
                      if (context.mounted) {
                        Navigator.pop(context); // Return to previous screen
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Failed to update task')),
                        );
                      }
                    }
                  },
                  child: const Text('Complete'),
                ),
              ],
            ),
          );
        } else if (title.contains('Add Time')) {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => AddTimeDialog(
              isGoal: false,
              itemId: task.id.toString(),
            ),
          );
        }
      },
      child: Column(
        children: [
          SvgPicture.asset(icon),
          eightVerticalSpace,
          Text(
            title,
            textAlign: TextAlign.center,
            style: tTextStyle500.copyWith(
              fontSize: 14,
              color: isComplete ? primaryColor : secondaryColor,
            ),
          )
        ],
      ),
    );
  }
}
