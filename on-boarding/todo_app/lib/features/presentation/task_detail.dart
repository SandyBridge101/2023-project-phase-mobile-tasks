import 'package:flutter/material.dart';
import 'package:todo_app/features/domain/logic.dart';
import 'package:intl/intl.dart';
import 'package:dartz/dartz.dart' hide State;

TextEditingController title_controller=TextEditingController();
TextEditingController description_controller=TextEditingController();
TextEditingController status_controller=TextEditingController();
const double sizedBoxHeight=20;


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

class TaskDetailScreen extends StatefulWidget{
  final int index;
  final task;


  const TaskDetailScreen({super.key,required this.index,required this.task});


  @override
  State<StatefulWidget> createState() => _TaskDetailScreenState(index: index,task: task);
}

class _TaskDetailScreenState extends State<TaskDetailScreen>{
  int index;
  var task;
  late String date_controller;

  _TaskDetailScreenState({required this.index,required this.task}){
    date_controller=task.convertDateToString();
    title_controller.text=task.title;
    description_controller.text=task.description;
  }



  Future<Widget> details_column(int index,BuildContext context)async{

    return Column(
      children: <Widget>[
        await _detail_card(index,"title",title_controller,200,50),
        SizedBox(height: sizedBoxHeight,),
        await _detail_card(index,"description",description_controller,200,200),

      ],
    );
  }

  Future<Widget> _detail_card (int index,String title,TextEditingController controller,double x, double y) async {
    List tasks= await TaskManager().ViewAllTasks();
    print('the tasks........');
    print(index);
    if (title=='title'){
      controller.text=tasks[index].title;
    }else{
      controller.text=tasks[index].description;
    }
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(
                title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),

            ),
          ),
          Container(
            width: x,
            height: y,
            child: Card(
              child: Container(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: 'input new task $title',
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }





  String? _selectedOption='pending';





  @override
  Widget build(BuildContext context) {

    // TODO: implement build


    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          child: Text('Task Detail'),
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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[

              Container(
                child: Image(
                  key: Key('task detail icon'),
                  width: 200,
                  height: 200,
                  image:AssetImage('lib/assets/tm2.jpg'),
                ),
              ),

              Container(
                child: FutureBuilder<Widget>(
                  future: details_column(index,context),
                  builder: (context, snapshot) {
                    // Checking if the future is resolved
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        // If the future resolved with an error
                        print(snapshot.error);
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        // When we got our data
                        return snapshot.data!;
                      }
                    }
                    // By default, show a loading spinner
                    return CircularProgressIndicator();
                  },
                ),
              ),

              SizedBox(height: sizedBoxHeight,),

              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(5),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "due_date",
                        style:TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),

                    SizedBox(height: sizedBoxHeight,),

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
                                date_controller,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              alignment: Alignment.centerLeft,
                              child: IconButton(
                                key: Key('task detail date button'),
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
                                      date_controller= DateFormat.yMMMd().format(pickedDate);
                                      print(date_controller);
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

                    SizedBox(height: sizedBoxHeight,),

                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(

                            alignment: Alignment.centerLeft,
                            child: Text(
                                "status",
                              style:TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Container(
                            child: Card(
                              child: Container(

                                child: DropdownButton<String>(
                                  key: Key('task detail status selector'),
                                  value: _selectedOption,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      print(newValue);
                                      _selectedOption = newValue!;
                                      status_controller.text=newValue;
                                    });
                                  },
                                  items: <String>['pending', 'complete', 'due']
                                      .map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: sizedBoxHeight,),

              Container(
                margin: EdgeInsets.all(10),
                child: ElevatedButton(
                  key: Key('task detail apply button'),
                  child: Text('Apply changes'),
                  onPressed: () async {

                    bool isvalid=false;
                    const snackBar=SnackBar(content: const Text('Invalid input'));
                    bool checker=title_controller.text!='' && description_controller.text!='' && date_controller!='';
                    Response response=Response(checker);
                    response.input.fold(
                            (l) => ScaffoldMessenger.of(context).showSnackBar(snackBar),
                            (r) => isvalid=true
                    );

                    if(isvalid){
                      await TaskManager().editTask(title_controller.text, description_controller.text, date_controller, status_controller.text, index);
                      Navigator.pop(context,'added');
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromRGBO(238, 111, 87, 1),
                    elevation: 5,
                  ),
                )
              ),



              Container(
                margin: EdgeInsets.all(10),
                  child: ElevatedButton(
                    key: Key('task detail delete button'),
                    child: Text('Delete Task'),
                    onPressed: () async {
                      await TaskManager().deleteTask(title_controller.text, description_controller.text, date_controller, status_controller.text, index);
                      Navigator.pop(context,'added');
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red,
                      elevation: 5,
                    ),
                  )
              )

            ],
          ),
        ),
      )
    );
  }
}

