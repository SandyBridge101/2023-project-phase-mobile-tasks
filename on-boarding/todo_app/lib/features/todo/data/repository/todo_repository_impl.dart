import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_app/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:todo_app/features/todo/data/datasources/todo_remote_data_source.dart';
import 'package:todo_app/features/todo/domain/entities/todo_task.dart';
import 'package:todo_app/features/todo/domain/repository/todo_repository.dart';
import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:todo_app/core/platform/network_info.dart';

class TodoRepositoryImpl implements TodoRepository{
  final TodoLocalDataSource todoLocalDataSource;
  final TodoRemoteDataSource todoRemoteDataSource;
  final NetworkInfo networkInfo;

  TodoRepositoryImpl({required this.todoLocalDataSource,required this.todoRemoteDataSource,required this.networkInfo});

  @override
  Future<Either<String , void>> deleteTask( int index) async {
    try{
      await todoLocalDataSource.deleteTask(index);
      return Right(null);
    }catch(e){
      return Left('Error in task deletion operation');
    }
  }

  @override
  Future<Either<String, void>> editTask(String title,String description,String date,String status,int index) async {
    try{
      await todoLocalDataSource.editTask(title, description, date, status, index);
      return Right(null);
    }catch(e){
      return Left('Error in task editing operation');
    }
  }

  @override
  Future<Either<String, List>> viewAllTasks() async {
    try{
      var connectionStatus=await networkInfo.isConnected;
      if(connectionStatus==false){
        print('could not connect');
        return Left('Could not connect');
      };
      final result=await todoLocalDataSource.viewAllTasks();
      return Right(result);
    }catch(e){
      return Left('Error in collecting data');
    }
  }

  @override
  Future<Either<String, Task>> viewTask(int index) async {
    try{
      final result=await todoLocalDataSource.viewTask(index);
      return Right(result);
    }catch(e){
      return Left('Error in collecting data');
    }
  }

  @override
  Future<Either<String, void>> createTask(Task task) async {
    try{
      await todoLocalDataSource.createTask(task);
      return Right(null);
    }catch(e){
      return Left('Error in collecting data');
    }
  }



}