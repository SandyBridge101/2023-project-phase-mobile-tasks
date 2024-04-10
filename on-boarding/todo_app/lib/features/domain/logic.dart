import 'package:todo_app/features/data/data_parser.dart';

class TaskManager {

  Future<void> addTask(String title, String description, String date, String status) async {
    await writeJson(title, description, date, status);
  }


  Future<List> getTasks() async{

    return await readJson();
  }

  Future<void> editTask(String title, String description, String date, String status, int index,)async{
    List tasks= await readJson();
    tasks.removeAt(index);
    await updateJson(index, title, description, date, status, tasks);
  }

  Future<void> deleteTask(String title, String description, String date, String status, int index,)async{
    List tasks= await readJson();
    tasks.removeAt(index);
    await refreshJson(index, title, description, date, status, tasks);
  }
}


