import 'package:todo_app/features/todo/domain/entities/todo_task.dart';
import 'package:todo_app/core/use_case/use_case.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_app/core/util/task_manager.dart';

class DeleteTask implements UseCase<List,int>{
  TaskManager taskManager;

  DeleteTask(this.taskManager);
  @override
  Future<Either<String,List>> call(int index) async {
    try{
      List tasks=await taskManager.deleteTask(index);
      return Right(tasks);
    }catch(e){
      return Left('Unable to add Task');
    }
  }
}