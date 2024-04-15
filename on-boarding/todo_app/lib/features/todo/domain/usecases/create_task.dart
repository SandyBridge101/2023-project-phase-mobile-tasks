import 'package:todo_app/features/todo/domain/entities/todo_task.dart';
import 'package:todo_app/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_app/features/todo/domain/repository/task_manager.dart';

class CreateTask extends UseCase<String,Task>{
  @override
  Future<Either<String,String>> call(Task task) async {
    try{
      await TaskManager().CreateTask(task.title!, task.description!,task.convertDateToString(), task.status!);
      return Right('Task Added');
    }catch(e){
      return Left('Unable to add Task');
    }

  }
}