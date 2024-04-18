import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_state.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_event.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:todo_app/core/util/task_manager.dart';

class MainScreen extends StatelessWidget{
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(238, 111, 87, 1),
      body:buildBody(context)
    );
  }
}

BlocProvider<TodoBloc> buildBody(BuildContext context){

  return BlocProvider(
    create:(_)=>TodoBloc(IntialState(),taskManager: TaskManager()),
    child: BlocBuilder<TodoBloc,TodoState>(
      builder: (context,state){
        if(state is IntialState){
          return Center(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image(
                      key: Key('main screen image'),
                      width: 500,
                      height: 500,
                      image:AssetImage('lib/assets/tm1.png'),
                    ),
                  ),
                  Container(
                    child: ElevatedButton(
                      key: Key('main screen button'),
                      child: Text('Get Started',
                          style:TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                          )
                      ),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(5)
                          )
                      ),
                      onPressed: (){
                        BlocProvider.of<TodoBloc>(context).add(LoadAllTasksEvent());
                        Navigator.pushNamed(context,'/todo');
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        }
        else{
          return Text('Error');
        }
      },
    ),
  );
}
