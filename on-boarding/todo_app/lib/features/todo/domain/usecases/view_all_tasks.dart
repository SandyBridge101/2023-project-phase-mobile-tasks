import 'package:todo_app/features/todo/data/models/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/features/todo/domain/repository/task_manager.dart';
import 'package:todo_app/core/use_case/use_case.dart';

class ViewAllTasks extends UseCase<List,NoParams>{
  @override
  Future<Either<String,List>>call(NoParams params)async{
    List tasks= await TaskManager().ViewAllTasks();

    if (tasks.isNotEmpty){
      return Right(tasks);
    }else{
      return Left('Could not retrieve tasks');
    }
  }
}
