import 'package:todo_app/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_app/features/todo/domain/repository/task_manager.dart';
import 'package:todo_app/features/todo/domain/entities/todo_task.dart';

class ViewTask extends UseCase<Task,int>{
  @override
  Future<Either<String,Task>>call(int id)async{
    List tasks= await TaskManager().ViewAllTasks();

    for (var task in tasks){
      if(task.id==id){
        return Right(task);
      }
    }

    return Left('Could not Find Task');
  }
}
