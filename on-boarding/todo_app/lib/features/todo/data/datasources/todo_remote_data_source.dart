import 'package:todo_app/features/todo/domain/entities/todo_task.dart';


abstract class TodoRemoteDataSource{
  Future<List> viewAllTasks();
  Future<Task> viewTask();
  Future<void> editTask();
  Future<void> deleteTask();
}