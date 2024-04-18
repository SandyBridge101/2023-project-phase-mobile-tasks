import 'package:todo_app/features/todo/data/models/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/core/util/task_manager.dart';
import 'package:todo_app/core/use_case/use_case.dart';

class ViewAllTasks implements UseCase<List,NoParams>{
  TaskManager taskManager;

  ViewAllTasks(this.taskManager);
  @override
  Future<Either<String,List>>call(NoParams params)async{
    try{
      List tasks= await TaskManager().ViewAllTasks();
      print('retrieve tasks');
      return Right(tasks);
    }catch(e){
      print('Could not retrieve tasks: $e');
      return Left('Could not retrieve tasks');
    }
  }
}
