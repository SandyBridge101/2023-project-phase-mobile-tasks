import 'package:equatable/equatable.dart';


abstract class TodoEvent {

}

class LoadAllTasksEvent extends TodoEvent{
  LoadAllTasksEvent(){
  }


}

class GetSingleTaskEvent extends TodoEvent{
  final index;
  GetSingleTaskEvent({required this.index});
}

class UpdateTaskEvent extends TodoEvent{
  final title;
  final description;
  final due_date;
  final status;
  final id;
  UpdateTaskEvent({required this.title,required this.description,required this.due_date,required this.status,required this.id});
}

class DeleteTaskEvent extends TodoEvent{
  final index;
  DeleteTaskEvent({required this.index});
}

class CreateTaskEvent extends TodoEvent{
  final id;
  final title;
  final description;
  final due_date;
  final status;
  CreateTaskEvent({required this.title,required this.description,required this.due_date,required this.status,required this.id});
}