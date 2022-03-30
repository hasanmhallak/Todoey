import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task.dart';

class BottomSheetWidgets extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  BottomSheetWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Add Task',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 30.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          TextField(
              onSubmitted: (txt) {
                Provider.of<TasksList>(context, listen: false).addToList(txt);

                Navigator.pop(context);
              },
              autofocus: true,
              controller: _controller),
          const SizedBox(
            height: 10.0,
          ),
          // ignore: deprecated_member_use
          FlatButton(
            onPressed: () {
              Provider.of<TasksList>(context, listen: false)
                  .addToList(_controller.text);

              Navigator.pop(context);
            },
            child: const Text('Add'),
            color: Colors.lightBlue,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
