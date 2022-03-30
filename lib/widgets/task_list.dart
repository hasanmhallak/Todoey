import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../widgets/task_tile_3.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';

class TaskList extends StatefulWidget {
  final Function? hideButton;

  const TaskList({Key? key, this.hideButton}) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TasksList>(
      builder: (context, tasksList, child) =>
          NotificationListener<UserScrollNotification>(
        onNotification: (notification) =>
            scrollListener(notification, widget.hideButton),
        child: disableScrollGlowingUp(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.startToEnd,
                key: UniqueKey(),
                onDismissed: (_) {
                  tasksList.deletTask(tasksList.tasks[index].id!);
                  //Showing snackBar
                  ScaffoldMessenger.of(context).showSnackBar(showSnack());
                },
                background: Container(
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    // borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  alignment: Alignment.centerLeft,
                  child: const Icon(
                    Icons.delete_forever,
                  ),
                ),
                child: TaskTile(
                  text: tasksList.tasks[index].name,
                  isChecked: tasksList.tasks[index].isDone,
                  callBack: (bool? value) =>
                      tasksList.checkTask(tasksList.tasks[index], value),
                ),
              );
            },
            itemCount: tasksList.tasks.length,
          ),
        ),
      ),
    );
  }
}

ScrollConfiguration disableScrollGlowingUp({Widget? child}) {
  return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      //Disabling Glowing Overscroll Indicator on the AxisDirection.up
      child: GlowingOverscrollIndicator(
          axisDirection: AxisDirection.down,
          color: Colors.blueAccent,
          showLeading: false,
          child: child!));
}

bool scrollListener(UserScrollNotification notification, Function? hideButton) {
  if (notification.direction == ScrollDirection.forward) {
    bool? isForward = true;
    hideButton!(isForward: isForward);
  } else if (notification.direction == ScrollDirection.reverse) {
    bool? isForward = false;
    hideButton!(isForward: isForward);
  }

  return true;
}

SnackBar showSnack() {
  return const SnackBar(
      duration: Duration(milliseconds: 600),
      content: Text('Task has been deleted!'));
}
