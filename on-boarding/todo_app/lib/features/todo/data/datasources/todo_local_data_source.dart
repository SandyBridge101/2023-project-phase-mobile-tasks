import 'package:todo_app/features/todo/domain/entities/todo_task.dart';
import 'package:todo_app/core/util/task_manager.dart';


abstract class TodoLocalDataSource{
  Future<List> viewAllTasks();
  Future<Task> viewTask(int index);
  Future<void> editTask(String title,String description,String date,String status,int index);
  Future<void> deleteTask(int index);
}

class TodoLocalDataSourceImpl extends TodoLocalDataSource{
  @override
  Future<void> deleteTask(int index) async {
    try{
      await TaskManager().deleteTask(index);
    }catch(e){
      print(e);
    }
  }

  @override
  Future<void> editTask (String title,String description,String date,String status,int index) async {
    try{
      await TaskManager().editTask(title, description, date, status, index);
    }catch(e){
      print(e);
    }
  }

  @override
  Future<List> viewAllTasks() async {
    try{
      return await TaskManager().ViewAllTasks();
    }catch(e){
      print(e);
      return[];
    }
  }

  @override
  Future<Task> viewTask(int index) async {

    return await TaskManager().ViewTask(index);
  }

}
