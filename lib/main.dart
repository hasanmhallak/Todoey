// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/task_screen.dart';
import './models/task.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(ChangeNotifierProvider(
      create: (context) => TasksList(), child: Todoey()));
}

class Todoey extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Provider.of<TasksList>(context, listen: false).refreshList();
    return MaterialApp(
      title: 'Todoey',
      home: TaskScreen(),
    );
  }
}
