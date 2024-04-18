
class TodoState {

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
  final List tasks;
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