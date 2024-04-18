import 'package:dartz/dartz.dart' hide State;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/core/util/task_manager.dart';
import 'package:todo_app/features/todo/presentation/pages/task_detail.dart';
import 'package:todo_app/features/todo/presentation/bloc/bloc.dart';
import 'package:todo_app/features/todo/presentation/bloc/todo_bloc.dart';

import 'package:todo_app/features/todo/domain/usecases/create_task.dart';
import 'package:todo_app/features/todo/domain/usecases/view_all_tasks.dart';
import 'package:todo_app/features/todo/domain/usecases/view_task.dart';
import 'package:todo_app/features/todo/domain/usecases/edit_task.dart';
import 'package:todo_app/features/todo/domain/usecases/delete_task.dart';

import 'package:bloc/bloc.dart';
import 'package:todo_app/injection_container.dart';

double primary_font_size=16;
double secondary_font_size=5;
const Color primary_color=Color(0xee6f57);

String feedback='';

class Response{
  late Either<String,List> list;

  Response(dynamic response){
    if(response is String){
      list=Left(response);
    }
    else{
      list=Right(response);
    }
  }
}

class TodoListScreen extends StatefulWidget{
  const TodoListScreen({super.key});

  @override
  State<StatefulWidget> createState() => _TodoListScreenState();
}
List tasks=[];
class _TodoListScreenState extends State<TodoListScreen>{

  Future<List<Widget>> _generate_todolist(BuildContext context,List tasks) async {
    //tasks= await TaskManager().ViewAllTasks();
    List<Widget> todo_list=[];
    int x=0;

    for (var task in tasks){
      todo_list.add(_task_card(x,task.title,task.convertDateToString(), 'lib/assets/alph_w.png',task.status,context));
      x++;
    }

    return todo_list;
  }

  Widget _task_card(int index,String title,String date,String icon_path,String status_,BuildContext context){
    Color status;
    if (status_=='pending'){
      status=Colors.yellow;
    }
    else if(status_=='complete'){
      status=Colors.green;
    }
    else{
      status=Colors.red;
    }
    return GestureDetector(
      key: Key('task$index card'),
      onTap:()async{
        List tasks= await TaskManager().ViewAllTasks();

        final feedback=await Navigator.push(context, MaterialPageRoute(builder:(context)=>TaskDetailScreen(index: index, task: tasks[index])));

        if(feedback=='added'){
          setState(() {});
        }

      },
      child:Container(
        margin: EdgeInsets.all(10),
        child: Card(

          elevation: 10,
          color: Colors.white,
          child: IntrinsicHeight(
            child: Row(
              children:<Widget> [
                Expanded(
                    child:Container(
                      width: 50,
                      height: 50,
                      child: Image(
                        image: AssetImage(icon_path),
                      ),
                    )
                ),

                Expanded(
                  child:Container(
                    padding: EdgeInsets.all(5),
                    margin: EdgeInsets.all(5),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: primary_font_size,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                    child:Container(
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.topRight,
                      child: Text(
                          date
                      ),
                    )
                ),

                Expanded(
                  child:Container(
                    child:VerticalDivider(
                      indent: 10,
                      thickness: 5,
                      width: 5,
                      color: status,
                      endIndent: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bodyDisplay(List tasks){
    return SingleChildScrollView(
      child:Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Image(
                      key: Key('todo icon'),
                      width: 200,
                      height: 200,
                      image:AssetImage('lib/assets/tm3.png'),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tasks List',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Container(
                    child: FutureBuilder<List<Widget>>(
                      future: _generate_todolist(context,tasks),
                      builder: (context, snapshot) {
                        // Checking if the future is resolved
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            // If the future resolved with an error
                            print(snapshot.error);
                            return Text('Error: ${snapshot.error}');
                          } else if (snapshot.hasData) {
                            // When we got our data
                            return Column(
                              children: snapshot.data!,
                            );
                          }

                        }
                        // By default, show a loading spinner
                        return CircularProgressIndicator();
                      },
                    ),
                  )
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                key: Key('create task button'),
                style: ElevatedButton.styleFrom(
                    foregroundColor:Colors.white ,
                    backgroundColor:Color.fromRGBO(238, 111, 87, 1),
                    shape: BeveledRectangleBorder(
                      borderRadius:BorderRadius.circular(0.2),
                    )

                ),
                child: Text('Create Task'),
                onPressed: ()async{
                  final feedback=await Navigator.pushNamed(context, '/create_task');

                  if(feedback=='added'){
                    setState(() {});
                  }
                },

              ),
            )
          ],
        ),
      ),
    );
  }

  BlocProvider<TodoBloc> buildBody(BuildContext context){

    return BlocProvider(
      create:(_)=> TodoBloc(LoadingState(),taskManager: TaskManager()),
      child: BlocBuilder<TodoBloc,TodoState>(
        builder: (context,state){
          bool isLoaded=false;
          if (state is LoadingState){
            print('loading State....');
            return Text('Loading....');
          }
          else if( state is LoadedAllTasksState){
            print('current state ......$isLoaded');
            return bodyDisplay(state.tasks);
          }
          return Text('Error');

        },
      ),

    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(tasks);
    setState(() {});
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child:Text('Todo List'),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String value) {
              setState(() {
              });
            },
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                value: '1',
                child: Text('Refresh'),
              ),
            ],
          )
        ],

        leading: IconButton(
          icon:Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(238, 111, 87, 1),
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),
      body: buildBody(context)
    );
  }
}





