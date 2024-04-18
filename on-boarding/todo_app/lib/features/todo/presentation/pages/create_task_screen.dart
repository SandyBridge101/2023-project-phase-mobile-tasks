
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/util/task_manager.dart';
import 'package:dartz/dartz.dart' hide State;
import 'package:todo_app/features/todo/presentation/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/features/todo/domain/usecases/create_task.dart';
import 'package:todo_app/features/todo/domain/usecases/view_all_tasks.dart';
import 'package:todo_app/features/todo/domain/usecases/view_task.dart';
import 'package:todo_app/features/todo/domain/usecases/edit_task.dart';
import 'package:todo_app/features/todo/domain/usecases/delete_task.dart';

final taskname_controller=TextEditingController();
final taskdate_controller=TextEditingController();
final description_controller=TextEditingController();



class Response{
  late Either<String,String> input;

  Response(dynamic response){
    if(response == false){
      input=Left('Invalid Input, Try again');
    }
    else{
      input=Right('Done');
    }
  }
}

class CreateTaskScreen extends StatefulWidget{
  const CreateTaskScreen({super.key});

  @override
  State<StatefulWidget> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen>{
  final GlobalKey<ScaffoldState> scaffoldKey=GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    setState(() {

    });
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
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

        title: Container(
          child: Text('Create new task',
            key: Key('create task header'),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          alignment:Alignment.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child:  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    _input_card('Enter Task name','Mobile Task Name',taskname_controller),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              key: Key('create task field'),
                              'Due date',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(238, 111, 87, 1),
                              ),
                            ),
                          ),
                          Container(
                            child: Card(
                              //TODO:Make width dynamic
                              shadowColor: Colors.black,
                              elevation:10 ,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    margin:EdgeInsets.all(10),
                                    child: Text(
                                      taskdate_controller.text,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: IconButton(
                                      key: Key('date picker'),
                                      icon: Icon(Icons.calendar_month),
                                      onPressed:() async {
                                        DateTime? pickedDate = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(3000),
                                        );
                                        if (pickedDate != null) {

                                          setState(() {
                                            taskdate_controller.text=DateFormat.yMMMd().format(pickedDate);
                                          });
                                        }
                                      },

                                      color: Color.fromRGBO(238, 111, 87, 1),
                                    ),
                                  )
                                ],
                              ),
                            ),

                          ),

                        ],
                      ),
                    ),
                    _input_card('Enter task description','Description',description_controller)
                  ],
                ),
              ),

              buildButton(context)
            ],
          ),
        ),
      )
    );
  }
}

Widget _input_card(String hint,String title,TextEditingController input_controller){
  var key=null;

  if (title=='Mobile Task Name'){
    key=Key('title field');
  }
  else{
    key=Key('description field');
  }

  return Container(
    margin: EdgeInsets.all(20),
    child: Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: Text(
              title,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(238, 111, 87, 1),
            ),
          ),
        ),
        Container(

          child: Card(
            //TODO:Make width dynamic
            shadowColor: Colors.black,
            elevation:10 ,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)
            ),
            child: Container(
              color: Colors.white,
              width: 500,
              child: TextField(
                key: key ,
                controller: input_controller,
                decoration: InputDecoration(
                    hintText: hint
                ),
              ),
            ),

          ),
        )
      ],
    ),
  );
}

// TODO: create input date class to extend main state
class InputDateCard extends State<CreateTaskScreen>{
  Widget _input_date_card(String hint,String title,TextEditingController input_controller, BuildContext context){
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(238, 111, 87, 1),
              ),
            ),
          ),
          Container(
            child: Card(
              //TODO:Make width dynamic
              shadowColor: Colors.black,
              elevation:10 ,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin:EdgeInsets.all(10),
                    child: Text(
                      input_controller.text,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.calendar_month),
                      onPressed:() async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(3000),
                        );
                        if (pickedDate != null) {

                          setState(() {
                            input_controller.text=pickedDate.toString();
                          });
                        }
                      },

                      color: Color.fromRGBO(238, 111, 87, 1),
                    ),
                  )
                ],
              ),
            ),

          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

BlocProvider<TodoBloc> buildButton(BuildContext context){

  return BlocProvider(
    create:(_)=>TodoBloc(IntialState(),taskManager: TaskManager()),
    child: BlocBuilder<TodoBloc,TodoState>(
      builder: (context,state){
        return Container(
          child: ElevatedButton(
            key: Key('create task button'),
            child: Text('Add Task'),
            onPressed: () async {
              bool isvalid=false;
              const snackBar=SnackBar(content: const Text('Invalid input'));
              bool checker=taskname_controller.text!='' && description_controller.text!='';
              Response response=Response(checker);
              response.input.fold(
                      (l) => ScaffoldMessenger.of(context).showSnackBar(snackBar),
                      (r) => isvalid=true
              );

              if(isvalid){
                BlocProvider.of<TodoBloc>(context).add(CreateTaskEvent(title: taskname_controller.text, description: description_controller.text, due_date: taskdate_controller.text, status: 'pending', id: 0));
                //await TaskManager().CreateTask(taskname_controller.text, description_controller.text, taskdate_controller.text, 'pending');
                // BlocProvider.of<TodoBloc>(context).add(LoadAllTasksEvent());
                Navigator.pop(context,'added');
              }
              taskname_controller.clear();
              taskdate_controller.clear();
              description_controller.clear();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color.fromRGBO(238, 111, 87, 1),
              elevation: 5,
            ),

          ),
        );
      },
    ),
  );
}
