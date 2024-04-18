import 'package:todo_app/features/todo/domain/entities/todo_task.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_app/core/util/task_manager.dart';

abstract class TodoRepository  {
  Future<Either<String,List>> viewAllTasks();
  Future<Either<String,Task>> viewTask(int index);
  Future<Either<String,void>> createTask(Task task);
  Future<Either<String,void>> editTask(String title,String description,String date,String status,int index);
  Future<Either<String,void>> deleteTask(int index);
  
}