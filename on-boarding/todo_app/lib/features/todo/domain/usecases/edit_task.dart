import 'package:todo_app/features/todo/domain/entities/todo_task.dart';
import 'package:todo_app/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_app/core/util/task_manager.dart';

class EditTask implements UseCase<String,Task>{
  TaskManager taskManager;

  EditTask(this.taskManager);
  @override
  Future<Either<String,String>> call(Task task) async {
    try{
      await taskManager.editTask(task.title!, task.description!,task.convertDateToString(), task.status!,task.id!);
      return Right('Task Added');
    }catch(e){
      return Left('Unable to add Task');
    }

  }
}