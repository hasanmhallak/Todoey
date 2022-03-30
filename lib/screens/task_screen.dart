import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../widgets/task_list.dart';
import '../widgets/bottom_sheet.dart';
import '../models/task.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class TaskScreen extends StatefulWidget {
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  bool isVisible = true;
  void hideButton({bool? isForward}) {
    if (isForward!) {
      if (!isVisible) {
        setState(() {
          isVisible = true;
        });
      }
    } else if (!isForward) {
      if (isVisible) {
        setState(() {
          isVisible = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  child: Icon(
                    Icons.list,
                    size: 30.0,
                    color: Colors.lightBlueAccent,
                  ),
                  backgroundColor: Colors.white,
                  radius: 30.0,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'Todoey',
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '${Provider.of<TasksList>(context).tasks.length} Tasks',
                  style: const TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ],
            ),
          ),
          mainContainer(),
        ],
      ),
      floatingActionButton: isVisible
          ? FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () => showBottomSheet(context),
              backgroundColor: Colors.lightBlueAccent,
            )
          : null,
    );
  }

  Widget mainContainer() {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0)),
        child: Container(
          padding: const EdgeInsets.only(top: 0.0),
          color: Colors.white,
          width: double.infinity,
          child: TaskList(hideButton: hideButton),
        ),
      ),
    );
  }
}

void showBottomSheet(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (context) => Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: BottomSheetWidgets(),
          ));
}
