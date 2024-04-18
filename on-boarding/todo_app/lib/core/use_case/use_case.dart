import 'package:equatable/equatable.dart';
import 'package:todo_app/features/todo/data/models/todo_model.dart';
import 'package:intl/intl.dart';
import 'package:dartz/dartz.dart';
import 'package:todo_app/core/util/task_manager.dart';


abstract class UseCase<Type,Params>{
  Future<Either<String,Type>>call(Params params);
}

class NoParams extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}



