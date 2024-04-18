import 'package:todo_app/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_app/core/util/task_manager.dart';
import 'package:todo_app/features/todo/domain/entities/todo_task.dart';

class ViewTask implements UseCase<Task,int>{
  TaskManager taskManager;

  ViewTask(this.taskManager);
  @override
  Future<Either<String,Task>>call(int id)async{
    List tasks= await taskManager.ViewAllTasks();

    for (var task in tasks){
      if(task.id==id){
        return Right(task);
      }
    }

    return Left('Could not Find Task');
  }
}
