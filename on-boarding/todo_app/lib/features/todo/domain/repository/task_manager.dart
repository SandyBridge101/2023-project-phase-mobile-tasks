import 'package:todo_app/features/todo/data/models/todo_model.dart';
import 'package:todo_app/features/todo/domain/entities/todo_task.dart';
import 'package:intl/intl.dart';
import 'package:dartz/dartz.dart' hide Task;


class TaskManager {
  List _tasks=<Task>[];

  Future<void> CreateTask(String title, String description, String date, String status) async {
    await writeJson(title, description, date, status);
    _tasks.add(Task(_tasks.length+1, title, description, DateFormat.yMMMd().parse(date), status));
  }

  Future<List> ViewAllTasks() async{
    var data=await readJson();
    int x=0;
    for(var task in data){
      _tasks.add(Task(x, task['title'], task['description'],DateFormat.yMMMd().parse(task['due_date']) , task['status']));
      x++;
    }
    return _tasks;
  }

  Future<Task> ViewTask(index) async{
    await ViewAllTasks();
    return _tasks[index];
  }

  Future<void> editTask(String title, String description, String date, String status, int index,)async{
    await ViewAllTasks();
    List data= await readJson();
    data.removeAt(index);
    await updateJson(index, title, description, date, status, data);

    _tasks[index]=Task(index, title, description,DateFormat.yMMMd().parse(date), status);
  }

  Future<void> deleteTask(String title, String description, String date, String status, int index,)async{
    await ViewAllTasks();
    List data= await readJson();
    data.removeAt(index);
    await refreshJson(index, title, description, date, status, data);
    _tasks.removeAt(index);
  }
}