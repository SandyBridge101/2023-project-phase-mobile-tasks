import 'package:todo_app/core/util/json_parser.dart';
import 'package:todo_app/features/todo/domain/entities/todo_task.dart';
import 'package:intl/intl.dart';
import 'package:dartz/dartz.dart' hide Task;


class TaskManager {
  List _tasks=<Task>[];

  Future<List> CreateTask(String title, String description, String date, String status) async {
    await writeJson(title, description, date, status);
    _tasks.add(Task(_tasks.length+1, title, description, DateFormat.yMMMd().parse(date), status));
    return _tasks;
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

  Future<List> editTask(String title, String description, String date, String status, int index)async{
    _tasks=await ViewAllTasks();
    List data= await readJson();
    data[index]["title"]=title;
    data[index]["description"]=description;
    data[index]["due_date"]=date;
    data[index]["status"]=status;
    await refreshJson(data);
    //await updateJson(index, title, description, date, status, data);

    _tasks[index]=Task(index, title, description,DateFormat.yMMMd().parse(date), status);



    return _tasks;
  }

  Future<List> deleteTask(int index,)async{
    await ViewAllTasks();
    List data= await readJson();
    data.removeAt(index);
    await refreshJson(data);
    _tasks.removeAt(index);
    print(_tasks);

    return _tasks;
  }
}