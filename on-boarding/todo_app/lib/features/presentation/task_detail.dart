import 'package:flutter/material.dart';
import 'package:todo_app/features/domain/logic.dart';
import 'package:intl/intl.dart';

TextEditingController title_controller=TextEditingController();

TextEditingController description_controller=TextEditingController();
TextEditingController status_controller=TextEditingController();


class TaskDetailScreen extends StatefulWidget{
  final int index;
  final List taskList;


  const TaskDetailScreen({super.key,required this.index,required this.taskList});


  @override
  State<StatefulWidget> createState() => _TaskDetailScreenState(index: index,taskList: taskList);
}

class _TaskDetailScreenState extends State<TaskDetailScreen>{
  int index;
  List taskList;


  _TaskDetailScreenState({required this.index,required this.taskList});



  Future<Widget> details_column(int index,BuildContext context)async{

    return Column(
      children: <Widget>[
        await _detail_card(index,"title",title_controller,200,50),
        await _detail_card(index,"description",description_controller,200,200),

      ],
    );
  }

  Future<Widget> _detail_card (int index,String title,TextEditingController controller,double x, double y) async {
    List tasks= await TaskManager().getTasks();
    print('the tasks........');
    print(index);
    controller.text=tasks[index][title];
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: Text(title),
          ),
          Container(
            width: x,
            height: y,
            child: Card(
              child: Container(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: tasks[index][title],
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
  String date_controller='';



  @override
  Widget build(BuildContext context) {

    // TODO: implement build

    setState(() {
      date_controller=taskList[index]['due_date'];
      _selectedOption=taskList[index]['status'];

    });

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
                  width: 200,
                  height: 200,
                  image:AssetImage('lib/assets/tm2.png'),
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

              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: Text("due_date"),
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
                                date_controller,
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

                    Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.all(20),
                            alignment: Alignment.centerLeft,
                            child: Text("status"),
                          ),
                          Container(
                            child: Card(
                              child: Container(
                                child: DropdownButton<String>(
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

              Container(
                child: ElevatedButton(
                  child: Text('Apply changes'),
                  onPressed: () async {
                    await TaskManager().editTask(title_controller.text, description_controller.text, date_controller, status_controller.text, index);
                    Navigator.pop(context,'added');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color.fromRGBO(238, 111, 87, 1),
                    elevation: 5,
                  ),
                )
              ),

              Container(
                  child: ElevatedButton(
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

