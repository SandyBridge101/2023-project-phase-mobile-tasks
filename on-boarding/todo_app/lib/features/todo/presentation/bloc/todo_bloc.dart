
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart' hide Task;
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:todo_app/core/use_case/use_case.dart';
import 'package:todo_app/core/util/task_manager.dart';
import 'package:todo_app/features/todo/domain/entities/todo_task.dart';

import 'package:todo_app/features/todo/domain/usecases/create_task.dart';
import 'package:todo_app/features/todo/domain/usecases/view_all_tasks.dart';
import 'package:todo_app/features/todo/domain/usecases/view_task.dart';
import 'package:todo_app/features/todo/domain/usecases/edit_task.dart';
import 'package:todo_app/features/todo/domain/usecases/delete_task.dart';


import './bloc.dart';

class TodoBloc extends Bloc<TodoEvent,TodoState>{
  ViewAllTasks viewAllTasks=ViewAllTasks(TaskManager());
  ViewTask viewTask=ViewTask(TaskManager());
  CreateTask createTask=CreateTask(TaskManager());
  EditTask editTask=EditTask(TaskManager());
  DeleteTask deleteTask=DeleteTask(TaskManager());
  final TaskManager taskManager;

  /*TodoBloc({required ViewAllTasks viewall,
            required ViewTask view,
            required CreateTask create,
            required this.taskManager
  }):assert(viewall!=null),
    assert(view!=null),
    assert(create!=null),
      viewAllTasks=viewall,
      viewTask=view,
      createTask=create;*/

  TodoBloc(super.initialState, {required this.taskManager});

  @override
  TodoState get initialState => IntialState();

  @override
  Stream<TodoState> mapEventToState( TodoEvent event)async*{
    if (event is CreateTaskEvent){
      //TODO: implement task argument
      // due_date is in DateTime format
      yield LoadingState();
      try{
        var k=event.due_date;
        print('Event date $k');
        //return list
        //yeild loaded task state
        final Either<String,List> tasks=await createTask(Task(event.id,event.title,event.description,DateFormat.yMMMd().parse(event.due_date), event.status));
        yield tasks.fold(
                (error) => ErrorState(),
                (task_list) => LoadedAllTasksState(tasks: task_list));

      }
      catch(e){
        yield ErrorState();
      }
    }
    else if(event is LoadAllTasksEvent){
      try{
        final Either<String,List> tasks=await viewAllTasks(NoParams());
        yield tasks.fold(
                (error) => ErrorState(),
                (task_list) => LoadedAllTasksState(tasks: task_list));

      }catch(e){
        ErrorState();
      }

    }
    else if(event is GetSingleTaskEvent){
      try{
        await viewTask!(event.index);
        yield LoadedSingleTaskState();
      }catch(e){
        yield ErrorState();
      }
    }

    else if (event is UpdateTaskEvent){
      yield LoadingState();

      try{
        final result=await editTask(Task(event.id, event.title, event.description, DateFormat.yMMMd().parse(event.due_date), event.status));
        //yield LoadedAllTasksState();
        result.fold(
                (l) => ErrorState(),
                (tasks) =>  LoadedAllTasksState(tasks: tasks));
      }catch(e){
        yield ErrorState();
      }


    }
    else if (event is DeleteTaskEvent){
      try{
        //yield LoadedAllTasksState();
        final result=await deleteTask(event.index);
        result.fold(
                (l) => ErrorState(),
                (tasks) =>  LoadedAllTasksState(tasks: tasks));

      }catch(e){
        yield ErrorState();
      }
    }

  }
}
