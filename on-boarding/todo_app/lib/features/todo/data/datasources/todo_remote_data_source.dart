import 'package:todo_app/features/todo/domain/entities/todo_task.dart';


abstract class TodoRemoteDataSource{
  Future<List> viewAllTasks();
  Future<Task> viewTask();
  Future<void> editTask();
  Future<void> deleteTask();
}

class TodoRemoteDataSourceImpl extends TodoRemoteDataSource{
  @override
  Future<void> deleteTask() {
    // TODO: implement deleteTask
    throw UnimplementedError();
  }

  @override
  Future<void> editTask() {
    // TODO: implement editTask
    throw UnimplementedError();
  }

  @override
  Future<List> viewAllTasks() {
    // TODO: implement viewAllTasks
    throw UnimplementedError();
  }

  @override
  Future<Task> viewTask() {
    // TODO: implement viewTask
    throw UnimplementedError();
  }


}
