import 'package:dartz/dartz.dart' hide Task;
import 'package:todo_app/core/use_case/use_case.dart';
import 'package:todo_app/core/util/task_manager.dart';
import 'package:todo_app/features/todo/domain/usecases/view_all_tasks.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class TodoState extends Equatable{
  @override
  List<Object> get props => [];
}

class IntialState extends TodoState{
  IntialState(){
    print('Initial state....');
  }
}

class LoadingState extends TodoState{
  LoadingState(){
    print('loading state....');
  }
}

class LoadedAllTasksState extends TodoState{
  List tasks;
  LoadedAllTasksState({required this.tasks}){
    print('loaded all tasks state....');

  }

}

class LoadedSingleTaskState extends TodoState{
  LoadedSingleTaskState(){
    print('loaded single task state....');
  }
}

class ErrorState extends TodoState{
  ErrorState(){
    print('error....');
  }
}

class Empty extends TodoState{
  Empty(){
    print('empty....');
  }
}