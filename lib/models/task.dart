import 'package:flutter/foundation.dart';
import '../database/database.dart';

class Task {
  String? name;
  bool? isDone;
  int? id;
  Task({@required this.name, this.isDone = false, this.id});
  void toggelDone(bool? value) => isDone = value;

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      DatabaseHelper.columnTask: name,
      DatabaseHelper.columnDone: isDone! ? 1 : 0,
      DatabaseHelper.columnId: id,
    };
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map[DatabaseHelper.columnId];
    name = map[DatabaseHelper.columnTask].toString();

    ///If it's equle  to one then true
    isDone = int.parse(map[DatabaseHelper.columnDone]) == 1 ? true : false;
  }
  @override
  String toString() => 'name: $name, isDone: $isDone, id: $id';
}

class TasksList extends ChangeNotifier {
  List<Task> tasks = [];

  Future<void> refreshList() async {
    List<Task> newTasks = await DatabaseHelper.dbConstructor.readAll();
    tasks = newTasks;
    notifyListeners();
  }

  void addToList(String name) async {
    await DatabaseHelper.dbConstructor.insert(Task(name: name));
    await refreshList();
    notifyListeners();
  }

  void checkTask(Task task, bool? value) async {
    task.toggelDone(value);
    await DatabaseHelper.dbConstructor.update(task);
    await refreshList();
    notifyListeners();
  }

  void deletTask(int id) async {
    await DatabaseHelper.dbConstructor.delet(id);
    await refreshList();
    notifyListeners();
  }
}
