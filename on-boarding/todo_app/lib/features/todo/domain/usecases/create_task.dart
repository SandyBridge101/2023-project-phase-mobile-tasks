import 'package:todo_app/features/todo/domain/entities/todo_task.dart';
import 'package:todo_app/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_app/core/util/task_manager.dart';

class CreateTask implements UseCase<List,Task>{
  TaskManager taskManager;

  CreateTask(this.taskManager);
  @override
  Future<Either<String,List>> call(Task task) async {
    try{
      List tasks=await TaskManager().CreateTask(task.title!, task.description!,task.convertDateToString(), task.status!);
      return Right(tasks);
    }catch(e){
      return Left('Unable to add Task');
    }
  }

}