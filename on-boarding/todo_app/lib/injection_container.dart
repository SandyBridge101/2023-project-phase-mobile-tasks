
import 'package:dartz/dartz.dart';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_app/core/util/task_manager.dart';

import 'package:todo_app/features/todo/domain/repository/todo_repository.dart';
import 'package:todo_app/features/todo/data/repository/todo_repository_impl.dart';
import 'package:todo_app/features/todo/data/datasources/todo_local_data_source.dart';
import 'package:todo_app/features/todo/data/datasources/todo_remote_data_source.dart';
import 'package:todo_app/features/todo/domain/usecases/create_task.dart';
import 'package:todo_app/features/todo/domain/usecases/edit_task.dart';
import 'package:todo_app/features/todo/domain/usecases/delete_task.dart';
import 'package:todo_app/features/todo/domain/usecases/view_task.dart';
import 'package:todo_app/features/todo/domain/usecases/view_all_tasks.dart';
import 'package:todo_app/features/todo/presentation/bloc/bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_state.dart';

final sl=GetIt.instance;

Future<void> init()async{
  //Bloc
  sl.registerFactory(() =>
      TodoBloc(
          sl(),
          taskManager: sl()
      )
  );


  //
  sl.registerLazySingleton(() => TaskManager().ViewAllTasks());
//States
  /*
  sl.registerLazySingleton(() => IntialState());
  sl.registerLazySingleton(() => LoadingState());
  sl.registerLazySingleton(() => LoadedAllTasksState(tasks: sl()));
  sl.registerLazySingleton(() => LoadedSingleTaskState());
   */
  sl.registerLazySingleton(() => TodoState());


  //Usecases
  sl.registerLazySingleton(() => CreateTask(sl()));
  sl.registerLazySingleton(() => EditTask(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));
  sl.registerLazySingleton(() => ViewTask(sl()));
  sl.registerLazySingleton(() => ViewAllTasks(sl()));

  //Repository
  sl.registerLazySingleton<TodoRepository>(() =>
      TodoRepositoryImpl(
          todoLocalDataSource: sl(),
          todoRemoteDataSource: sl(),
          networkInfo: sl()
      )
  );

  //Datasources
  sl.registerLazySingleton<TodoLocalDataSource>(() => TodoLocalDataSourceImpl());
  sl.registerLazySingleton<TodoRemoteDataSource>(() => TodoRemoteDataSourceImpl());
  
  //Core
  sl.registerLazySingleton(() => TaskManager());

  
  
}